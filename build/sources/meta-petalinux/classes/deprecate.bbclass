ALTERNATIVE ?= ""

python do_deprecate() {
  package = d.getVar('PN', True)
  alternative = d.getVar('ALTERNATIVE', True)
  if alternative:
    bb.warn("Deprecated package %s, use %s instead" % (package, alternative))
  else:
    bb.warn("Deprecated package %s")
}
addtask deprecate before do_fetch do_unpack do_patch do_populate_lic do_preconfigure
