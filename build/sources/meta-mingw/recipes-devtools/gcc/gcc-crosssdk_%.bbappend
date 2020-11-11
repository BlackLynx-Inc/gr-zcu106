EXTRA_OECONF_mingw32 := "${@oe_filter_out('--with-linker-hash-style=${LINKER_HASH_STYLE}', '${EXTRA_OECONF}', d)}"
PACKAGECONFIG_CONFARGS ?= ""
EXTRA_OECONF_remove_mingw32 = "--enable-initfini-array"
EXTRA_OECONF_append_mingw32 = " --disable-initfini-array"
