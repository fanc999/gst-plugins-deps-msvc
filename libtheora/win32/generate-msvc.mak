# NMake Makefile portion for code generation and
# intermediate build directory creation
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.

# Create the build directories
$(CFG)\$(PLAT)\libtheora $(CFG)\$(PLAT)\getopt $(CFG)\$(PLAT)\theora-ex $(CFG)\$(PLAT)\tests:
	@-md $@
