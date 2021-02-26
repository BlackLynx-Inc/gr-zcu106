Instructions to build custom bitstream and include in Yocto build

1. Open .xpr project file in Vivado 2020.1 tool.
2. Make changes to PL if needed.
3. It is good practice to update the Version register constants, to be able to confirm that the correct PL was included in Yocto build and deployed on board.
4. Generate Bistream in Vivado
5. After bistream is ready, go to "Export Hardware" in Vivado tool.
6. Export hardware (including bitstream). (Note: Vivado 2020.1 has a bug in that even if you select the "include bitstream" option in the GUI, the backend tcl command does not
   pick up this option. To workaround, send the command in tcl window with  -include bitstream option.
6. The .xsa file that is created contains all the hardware details that is needed for software.
7. Copy .xsa file and change the build/conf/local.conf file to point to the newly created .xsa file.

Read Version Registers

Once board is booted, peek command can be used to confirm Version registers.
(Note: Physical address changes when PL design is changed. Confirm in PL address editor)

peek 0x000A_0001

peek 0x000A_0002
