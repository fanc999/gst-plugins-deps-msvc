# NMake Makefile portion for code generation and
# intermediate build directory creation
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.

# Create the build directories
vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123	vs$(VSVER)\$(CFG)\$(PLAT)\libout123:
	@-mkdir $@
