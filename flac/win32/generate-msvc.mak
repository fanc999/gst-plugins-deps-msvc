# NMake Makefile portion for code generation and
# intermediate build directory creation
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.

# Create the build directories
$(CFG)\$(PLAT)\ex-c-decode	\
$(CFG)\$(PLAT)\ex-c-encode	\
$(CFG)\$(PLAT)\ex-cpp-decode	\
$(CFG)\$(PLAT)\ex-cpp-encode	\
$(CFG)\$(PLAT)\flac	\
$(CFG)\$(PLAT)\flacdiff	\
$(CFG)\$(PLAT)\flactimer	\
$(CFG)\$(PLAT)\libflac	\
$(CFG)\$(PLAT)\libflac++	\
$(CFG)\$(PLAT)\libflac-static	\
$(CFG)\$(PLAT)\metaflac	\
$(CFG)\$(PLAT)\share	\
$(CFG)\$(PLAT)\share-tests	\
$(CFG)\$(PLAT)\test-flac	\
$(CFG)\$(PLAT)\test-flac++	\
$(CFG)\$(PLAT)\utils:
	@-md $@
