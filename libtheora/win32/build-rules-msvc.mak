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

{..\lib\}.c{$(CFG)\$(PLAT)\libtheora\}.obj::
	$(CC) $(CFLAGS) $(LIBTHEORA_DEFINES) /Fo$(CFG)\$(PLAT)\libtheora\ /c @<<
$<
<<

{..\lib\x86_vc}.c{$(CFG)\$(PLAT)\libtheora\}.obj::
	$(CC) $(CFLAGS) $(LIBTHEORA_DEFINES) /Fo$(CFG)\$(PLAT)\libtheora\ /c @<<
$<
<<

{}.c{$(CFG)\$(PLAT)\getopt\}.obj::
	$(CC) $(CFLAGS) $(THEORA_DEFINES) /Fo$(CFG)\$(PLAT)\getopt\ /c @<<
$<
<<

{..\examples\}.c{$(CFG)\$(PLAT)\theora-ex\}.obj::
	$(CC) $(CFLAGS) $(THEORA_DEFINES) /Fo$(CFG)\$(PLAT)\theora-ex\ /c @<<
$<
<<

{..\tests\}.c{$(CFG)\$(PLAT)\tests\}.obj::
	$(CC) $(CFLAGS) $(THEORA_DEFINES) /Fo$(CFG)\$(PLAT)\tests\ /c @<<
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
$(THEORA_LIB): $(CFG)\$(PLAT)\theora.dll
$(THEORAENC_LIB): $(CFG)\$(PLAT)\theoraenc.dll
$(THEORADEC_LIB): $(CFG)\$(PLAT)\theoradec.dll

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(CFG)\$(PLAT)\theora.dll: $(CFG)\$(PLAT)\libtheora $(theora_dll_OBJS)
	link /DLL $(LDFLAGS) $(THEORA_DEP_LIBS) -out:$@ @<<
$(theora_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

$(CFG)\$(PLAT)\theoraenc.dll: $(CFG)\$(PLAT)\libtheora  $(theoraenc_dll_OBJS)
	link /DLL $(LDFLAGS) $(THEORA_DEP_LIBS) -out:$@ @<<
$(theoraenc_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

$(CFG)\$(PLAT)\theoradec.dll: $(CFG)\$(PLAT)\libtheora $(theoradec_dll_OBJS)
	link /DLL $(LDFLAGS) $(THEORA_DEP_LIBS) -out:$@ @<<
$(theoradec_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\theora-ex-dump-video.exe: $(THEORA_LIBS) $(CFG)\$(PLAT)\getopt $(CFG)\$(PLAT)\theora-ex $(THEORA_EX_DUMP_VIDEO_OBJS)
	link $(LDFLAGS) $(THEORA_LIBS) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_EX_DUMP_VIDEO_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\theora-ex-dump-psnr.exe: $(THEORA_LIBS) $(CFG)\$(PLAT)\getopt $(CFG)\$(PLAT)\theora-ex $(THEORA_EX_DUMP_PSNR_OBJS)
	link $(LDFLAGS) $(THEORA_LIBS) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_EX_DUMP_PSNR_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\theora-ex-encoder.exe: $(THEORA_LIBS) $(CFG)\$(PLAT)\getopt $(CFG)\$(PLAT)\theora-ex $(THEORA_EX_ENCODER_OBJS)
	link $(LDFLAGS) $(THEORA_LIBS) $(THEORA_DEP_LIBS) vorbis.lib -out:$@ @<<
$(THEORA_EX_ENCODER_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\comment.exe: $(THEORA_LIB) $(CFG)\$(PLAT)\tests $(THEORA_COMMENT_TEST_OBJ)
	link $(LDFLAGS) $(THEORA_LIB) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_COMMENT_TEST_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\comment_theora.exe: $(THEORA_LIB) $(CFG)\$(PLAT)\tests $(THEORA_COMMENT_THEORA_TEST_OBJ)
	link $(LDFLAGS) $(THEORA_LIB) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_COMMENT_THEORA_TEST_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\granulepos.exe: $(THEORA_LIB) $(CFG)\$(PLAT)\tests $(THEORA_GRANULE_TEST_OBJ)
	link $(LDFLAGS) $(THEORA_LIB) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_GRANULE_TEST_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\granulepos_theora.exe: $(THEORA_LIB) $(CFG)\$(PLAT)\tests $(THEORA_GRANULE_THEORA_TEST_OBJ)
	link $(LDFLAGS) $(THEORA_LIB) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_GRANULE_THEORA_TEST_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\noop.exe: $(THEORA_LIB) $(CFG)\$(PLAT)\tests $(THEORA_NOOP_TEST_OBJ)
	link $(LDFLAGS) $(THEORA_LIB) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_NOOP_TEST_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\noop_theora.exe: $(THEORA_LIB) $(CFG)\$(PLAT)\tests $(THEORA_NOOP_THEORA_TEST_OBJ)
	link $(LDFLAGS) $(THEORA_LIB) $(THEORA_DEP_LIBS) -out:$@ @<<
$(THEORA_NOOP_THEORA_TEST_OBJ)
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
	@-if exist $(CFG)\$(PLAT)\*.exe del /f /q $(CFG)\$(PLAT)\*.exe
	@-if exist $(CFG)\$(PLAT)\*.dll del /f /q $(CFG)\$(PLAT)\*.dll.manifest
	@-del /f /q $(CFG)\$(PLAT)\*.dll
	@-del /f /q $(CFG)\$(PLAT)\*.ilk
	@-del /f /q $(CFG)\$(PLAT)\*.obj
	@-del /f /q $(CFG)\$(PLAT)\tests\*.obj
	@-del /f /q $(CFG)\$(PLAT)\theora-ex\*.obj
	@-del /f /q $(CFG)\$(PLAT)\libtheora\*.obj
	@-del /f /q vc$(VSVER)0.pdb
	@-rmdir /s /q $(CFG)\$(PLAT)
