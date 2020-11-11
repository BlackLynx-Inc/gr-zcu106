#
# See docs/misc/xen-makefiles/makefiles.rst on variables that can be used in
# Makefile and are consumed by Rules.mk
#

-include $(BASEDIR)/include/config/auto.conf

include $(XEN_ROOT)/Config.mk
include $(BASEDIR)/scripts/Kbuild.include


ifneq ($(origin crash_debug),undefined)
$(error "You must use 'make menuconfig' to enable/disable crash_debug now.")
endif
ifeq ($(origin debug),command line)
$(warning "You must use 'make menuconfig' to enable/disable debug now.")
endif
ifneq ($(origin frame_pointer),undefined)
$(error "You must use 'make menuconfig' to enable/disable frame_pointer now.")
endif
ifneq ($(origin kexec),undefined)
$(error "You must use 'make menuconfig' to enable/disable kexec now.")
endif
ifneq ($(origin lock_profile),undefined)
$(error "You must use 'make menuconfig' to enable/disable lock_profile now.")
endif
ifneq ($(origin perfc),undefined)
$(error "You must use 'make menuconfig' to enable/disable perfc now.")
endif
ifneq ($(origin verbose),undefined)
$(error "You must use 'make menuconfig' to enable/disable verbose now.")
endif

TARGET := $(BASEDIR)/xen

# Note that link order matters!
ALL_OBJS-y               += $(BASEDIR)/common/built_in.o
ALL_OBJS-y               += $(BASEDIR)/drivers/built_in.o
ALL_OBJS-$(CONFIG_X86)   += $(BASEDIR)/lib/built_in.o
ALL_OBJS-y               += $(BASEDIR)/xsm/built_in.o
ALL_OBJS-y               += $(BASEDIR)/arch/$(TARGET_ARCH)/built_in.o
ALL_OBJS-$(CONFIG_CRYPTO)   += $(BASEDIR)/crypto/built_in.o

# Initialise some variables
targets :=
CFLAGS-y :=
AFLAGS-y :=

ALL_OBJS := $(ALL_OBJS-y)

SPECIAL_DATA_SECTIONS := rodata $(foreach a,1 2 4 8 16, \
                                            $(foreach w,1 2 4, \
                                                        rodata.str$(w).$(a)) \
                                            rodata.cst$(a)) \
                         $(foreach r,rel rel.ro,data.$(r).local)

include Makefile

# Linking
# ---------------------------------------------------------------------------

quiet_cmd_ld = LD      $@
cmd_ld = $(LD) $(XEN_LDFLAGS) -r -o $@ $(real-prereqs)

# Objcopy
# ---------------------------------------------------------------------------

quiet_cmd_objcopy = OBJCOPY $@
cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $< $@

define gendep
    ifneq ($(1),$(subst /,:,$(1)))
        DEPS += $(dir $(1)).$(notdir $(1)).d
    endif
endef
$(foreach o,$(filter-out %/,$(obj-y) $(obj-bin-y) $(extra-y)),$(eval $(call gendep,$(o))))

# Handle objects in subdirs
# ---------------------------------------------------------------------------
# o if we encounter foo/ in $(obj-y), replace it by foo/built_in.o
#   and add the directory to the list of dirs to descend into: $(subdir-y)
subdir-y := $(subdir-y) $(filter %/, $(obj-y))
obj-y    := $(patsubst %/, %/built_in.o, $(obj-y))

# $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
# tell kbuild to descend
subdir-obj-y := $(filter %/built_in.o, $(obj-y))

$(filter %.init.o,$(obj-y) $(obj-bin-y) $(extra-y)): CFLAGS-y += -DINIT_SECTIONS_ONLY

ifeq ($(CONFIG_COVERAGE),y)
ifeq ($(CONFIG_CC_IS_CLANG),y)
    COV_FLAGS := -fprofile-instr-generate -fcoverage-mapping
else
    COV_FLAGS := -fprofile-arcs -ftest-coverage
endif
$(filter-out %.init.o $(nocov-y),$(obj-y) $(obj-bin-y) $(extra-y)): CFLAGS-y += $(COV_FLAGS)
endif

ifeq ($(CONFIG_UBSAN),y)
# Any -fno-sanitize= options need to come after any -fsanitize= options
$(filter-out %.init.o $(noubsan-y),$(obj-y) $(obj-bin-y) $(extra-y)): \
CFLAGS-y += $(filter-out -fno-%,$(CFLAGS_UBSAN)) $(filter -fno-%,$(CFLAGS_UBSAN))
endif

ifeq ($(CONFIG_LTO),y)
# Would like to handle all object files as bitcode, but objects made from
# pure asm are in a different format and have to be collected separately.
# Mirror the directory tree, collecting them as built_in_bin.o.
# If there are no binary objects in a given directory, make a dummy .o
obj-bin-y += $(patsubst %/built_in.o,%/built_in_bin.o,$(filter %/built_in.o,$(obj-y)))
else
# For a non-LTO build, bundle obj-bin targets in with the normal objs.
obj-y += $(obj-bin-y)
obj-bin-y :=
endif

# Always build obj-bin files as binary even if they come from C source. 
$(obj-bin-y): XEN_CFLAGS := $(filter-out -flto,$(XEN_CFLAGS))

# Calculation of flags, first the generic flags, then the arch specific flags,
# and last the flags modified for a target or a directory.

c_flags = -MMD -MP -MF $(@D)/.$(@F).d $(XEN_CFLAGS) '-D__OBJECT_FILE__="$@"'
a_flags = -MMD -MP -MF $(@D)/.$(@F).d $(XEN_AFLAGS)

include $(BASEDIR)/arch/$(TARGET_ARCH)/Rules.mk

c_flags += $(CFLAGS-y)
a_flags += $(CFLAGS-y) $(AFLAGS-y)

built_in.o: $(obj-y) $(extra-y)
ifeq ($(obj-y),)
	$(CC) $(c_flags) -c -x c /dev/null -o $@
else
ifeq ($(CONFIG_LTO),y)
	$(LD_LTO) -r -o $@ $(filter-out $(extra-y),$^)
else
	$(LD) $(XEN_LDFLAGS) -r -o $@ $(filter-out $(extra-y),$^)
endif
endif

targets += built_in.o
targets += $(filter-out $(subdir-obj-y), $(obj-y)) $(extra-y)
targets += $(MAKECMDGOALS)

built_in_bin.o: $(obj-bin-y) $(extra-y)
ifeq ($(obj-bin-y),)
	$(CC) $(a_flags) -c -x assembler /dev/null -o $@
else
	$(LD) $(XEN_LDFLAGS) -r -o $@ $(filter-out $(extra-y),$^)
endif

# Force execution of pattern rules (for which PHONY cannot be directly used).
PHONY += FORCE
FORCE:

%/built_in.o: FORCE
	$(MAKE) -f $(BASEDIR)/Rules.mk -C $* built_in.o

%/built_in_bin.o: FORCE
	$(MAKE) -f $(BASEDIR)/Rules.mk -C $* built_in_bin.o

SRCPATH := $(patsubst $(BASEDIR)/%,%,$(CURDIR))

%.o: %.c Makefile
ifeq ($(CONFIG_ENFORCE_UNIQUE_SYMBOLS),y)
	$(CC) $(c_flags) -c $< -o $(@D)/.$(@F).tmp -MQ $@
ifeq ($(CONFIG_CC_IS_CLANG),y)
	$(OBJCOPY) --redefine-sym $<=$(SRCPATH)/$< $(@D)/.$(@F).tmp $@
else
	$(OBJCOPY) --redefine-sym $(<F)=$(SRCPATH)/$< $(@D)/.$(@F).tmp $@
endif
	rm -f $(@D)/.$(@F).tmp
else
	$(CC) $(c_flags) -c $< -o $@
endif

quiet_cmd_cc_o_S = CC      $@
cmd_cc_o_S = $(CC) $(a_flags) -c $< -o $@

%.o: %.S FORCE
	$(call if_changed,cc_o_S)


quiet_cmd_obj_init_o = INIT_O  $@
define cmd_obj_init_o
    $(OBJDUMP) -h $< | sed -n '/[0-9]/{s,00*,0,g;p;}' | while read idx name sz rest; do \
        case "$$name" in \
        .*.local) ;; \
        .text|.text.*|.data|.data.*|.bss) \
            test $$sz != 0 || continue; \
            echo "Error: size of $<:$$name is 0x$$sz" >&2; \
            exit $$(expr $$idx + 1);; \
        esac; \
    done; \
    $(OBJCOPY) $(foreach s,$(SPECIAL_DATA_SECTIONS),--rename-section .$(s)=.init.$(s)) $< $@
endef

$(filter %.init.o,$(obj-y) $(obj-bin-y) $(extra-y)): %.init.o: %.o FORCE
	$(call if_changed,obj_init_o)

quiet_cmd_cpp_i_c = CPP     $@
cmd_cpp_i_c = $(CPP) $(filter-out -Wa$(comma)%,$(c_flags)) $< -o $@

quiet_cmd_cc_s_c = CC      $@
cmd_cc_s_c = $(CC) $(filter-out -Wa$(comma)%,$(c_flags)) -S $< -o $@

quiet_cmd_s_S = CPP     $@
cmd_s_S = $(CPP) $(filter-out -Wa$(comma)%,$(a_flags)) $< -o $@

%.i: %.c FORCE
	$(call if_changed,cpp_i_c)

%.s: %.c FORCE
	$(call if_changed,cc_s_c)

%.s: %.S FORCE
	$(call if_changed,cpp_s_S)

# Add intermediate targets:
# When building objects with specific suffix patterns, add intermediate
# targets that the final targets are derived from.
intermediate_targets = $(foreach sfx, $(2), \
				$(patsubst %$(strip $(1)),%$(sfx), \
					$(filter %$(strip $(1)), $(targets))))
# %.init.o <- %.o
targets += $(call intermediate_targets, .init.o, .o)

-include $(DEPS_INCLUDE)

# Read all saved command lines and dependencies for the $(targets) we
# may be building above, using $(if_changed{,_dep}). As an
# optimization, we don't need to read them if the target does not
# exist, we will rebuild anyway in that case.

existing-targets := $(wildcard $(sort $(targets)))

-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)

# Declare the contents of the PHONY variable as phony.  We keep that
# information in a variable so we can use it in if_changed and friends.
.PHONY: $(PHONY)
