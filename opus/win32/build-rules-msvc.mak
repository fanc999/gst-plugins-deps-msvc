# NMake Makefile portion for compilation rules
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.  The format
# of NMake Makefiles here are different from the GNU
# Makefiles.  Please see the comments about these formats.

# Inference rules for compiling the .obj files.
# Used for libs and programs with more than a single source file.
# Format is as follows
# (all dirs must have a trailing '\'):
#
# {$(srcdir)}.$(srcext){$(destdir)}.obj::
# 	$(CC)|$(CXX) $(cflags) /Fo$(destdir) /c @<<
# $<
# <<

{..\src\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\celt\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\celt\x86\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\silk\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\silk\x86\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\silk\float\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\silk\fixed\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\silk\fixed\x86\}.c{$(CFG)\$(PLAT)\libopus\}.obj::
	$(CC) $(CFLAGS) $(LIBOPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\libopus\ /c @<<
$<
<<

{..\src\}.c{$(CFG)\$(PLAT)\demo\}.obj::
	$(CC) $(CFLAGS) $(OPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\demo\ /c @<<
$<
<<

{..\tests\}.c{$(CFG)\$(PLAT)\tests\}.obj::
	$(CC) $(CFLAGS) $(OPUS_DEFINES) $(LIBOPUS_BASE_CFLAGS) /Fo$(CFG)\$(PLAT)\tests\ /c @<<
$<
<<

# Inference rules for building the test programs
# Used for programs with a single source file.
# Format is as follows
# (all dirs must have a trailing '\'):
#
# {$(srcdir)}.$(srcext){$(destdir)}.exe::
# 	$(CC)|$(CXX) $(cflags) $< /Fo$*.obj  /Fe$@ [/link $(linker_flags) $(dep_libs)]

# Rules for building .lib files
$(OPUS_LIB): $(CFG)\$(PLAT)\opus.dll

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(CFG)\$(PLAT)\opus.dll: $(CFG)\$(PLAT)\libopus\version.h $(opus_dll_OBJS)
	link /DLL $(LDFLAGS) -out:$@ @<<
$(opus_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\opus-demo.exe: $(OPUS_LIB) $(CFG)\$(PLAT)\demo $(OPUS_DEMO_OBJ)
	link $(LDFLAGS) $(OPUS_LIB) -out:$@ @<<
$(OPUS_DEMO_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\test-opus-api.exe: $(OPUS_LIB) $(CFG)\$(PLAT)\tests $(OPUS_TEST_API_OBJ)
	link $(LDFLAGS) $(OPUS_LIB) -out:$@ @<<
$(OPUS_TEST_API_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\test-opus-decode.exe: $(OPUS_LIB) $(CFG)\$(PLAT)\tests $(OPUS_TEST_DECODE_OBJ)
	link $(LDFLAGS) $(OPUS_LIB) -out:$@ @<<
$(OPUS_TEST_DECODE_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\test-opus-encode.exe: $(OPUS_LIB) $(CFG)\$(PLAT)\tests $(OPUS_TEST_ENCODE_OBJS)
	link $(LDFLAGS) $(OPUS_LIB) -out:$@ @<<
$(OPUS_TEST_ENCODE_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\test-opus-padding.exe: $(OPUS_LIB) $(CFG)\$(PLAT)\tests $(OPUS_TEST_PADDING_OBJ)
	link $(LDFLAGS) $(OPUS_LIB) -out:$@ @<<
$(OPUS_TEST_PADDING_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

# Other .obj files requiring individual attention, that could not be covered by the inference rules.
# Format is as follows (all dirs must have a trailing '\'):
#
# $(obj_file):
# 	$(CC)|$(CXX) $(cflags) /Fo$(obj_destdir) /c @<<
# $(srcfile)
# <<

###

clean:
	@-del /f /q $(CFG)\$(PLAT)\*.pdb
	@-if exist $(CFG)\$(PLAT)\*.exe.manifest del /f /q $(CFG)\$(PLAT)\*.exe.manifest
	@-del /f /q $(CFG)\$(PLAT)\*.exe
	@-if exist $(CFG)\$(PLAT)\*.dll del /f /q $(CFG)\$(PLAT)\*.dll.manifest
	@-del /f /q $(CFG)\$(PLAT)\*.dll
	@-del /f /q $(CFG)\$(PLAT)\*.ilk
	@-del /f /q $(CFG)\$(PLAT)\*.obj
	@-del /f /q $(CFG)\$(PLAT)\tests\*.obj
	@-del /f /q $(CFG)\$(PLAT)\demo\*.obj
	@-del /f /q $(CFG)\$(PLAT)\libopus\version.h
	@-del /f /q $(CFG)\$(PLAT)\libopus\*.obj
	@-del /f /q vc$(VSVER)0.pdb
	@-rmdir /s /q $(CFG)\$(PLAT)
