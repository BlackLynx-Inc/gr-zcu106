LINUX_VERSION = "4.14"
XILINX_RELEASE_VERSION = "v2018.3"
BRANCH_KERNEL ??= "xlnx_rebase_v4.14"
KBRANCH = "${BRANCH_KERNEL}"
SRCREV ??= "eeab73d1207d6fc2082776c954eb19fd7290bfbe"

include linux-xlnx.inc

