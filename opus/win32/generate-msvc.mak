# NMake Makefile portion for code generation and
# intermediate build directory creation
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.

# Create the build directories
$(CFG)\$(PLAT)\libopus $(CFG)\$(PLAT)\demo $(CFG)\$(PLAT)\tests:
	@-md $@

$(CFG)\$(PLAT)\libopus\version.h: $(CFG)\$(PLAT)\libopus
	echo #define PACKAGE_VERSION "1.2.1" > $@
