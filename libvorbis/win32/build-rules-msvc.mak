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

{..\lib\}.c{$(CFG)\$(PLAT)\libvorbis\}.obj::
	$(CC) $(CFLAGS) $(VORBIS_DEFINES) /Fo$(CFG)\$(PLAT)\libvorbis\ /c @<<
$<
<<

{..\examples\}.c{$(CFG)\$(PLAT)\vorbis-ex\}.obj::
	$(CC) $(CFLAGS) $(VORBIS_EX_DEFINES) /Fo$(CFG)\$(PLAT)\vorbis-ex\ /c @<<
$<
<<

{..\test\}.c{$(CFG)\$(PLAT)\test\}.obj::
	$(CC) $(CFLAGS) $(VORBIS_TEST_DEFINES) /Fo$(CFG)\$(PLAT)\test\ /c @<<
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
$(VORBIS_LIB): $(CFG)\$(PLAT)\vorbis.dll
$(VORBISENC_LIB): $(CFG)\$(PLAT)\vorbisenc.dll
$(VORBISFILE_LIB): $(CFG)\$(PLAT)\vorbisfile.dll

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(CFG)\$(PLAT)\vorbis.dll: $(CFG)\$(PLAT)\libvorbis $(vorbis_dll_OBJS)
	link /DLL $(LDFLAGS) $(VORBIS_DEP_LIBS) -out:$@ /def:$(@B).def @<<
$(vorbis_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

$(CFG)\$(PLAT)\vorbisenc.dll: $(VORBIS_LIB) $(vorbisenc_dll_OBJS)
	link /DLL $(LDFLAGS) $(VORBIS_LIB) $(VORBIS_DEP_LIBS) -out:$@ /def:$(@B).def @<<
$(vorbisenc_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

$(CFG)\$(PLAT)\vorbisfile.dll: $(VORBIS_LIB) $(vorbisfile_dll_OBJS)
	link /DLL $(LDFLAGS) $(VORBIS_LIB) $(VORBIS_DEP_LIBS) -out:$@ /def:$(@B).def @<<
$(vorbisfile_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\vorbis-ex-chaining.exe: $(VORBIS_LIBS) $(CFG)\$(PLAT)\vorbis-ex $(EX_CHAINING_OBJ)
	link $(LDFLAGS) $(VORBIS_LIBS) $(VORBIS_DEP_LIBS) -out:$@ @<<
$(EX_CHAINING_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\vorbis-ex-decoder.exe: $(VORBIS_LIBS) $(CFG)\$(PLAT)\vorbis-ex $(EX_DECODER_OBJ)
	link $(LDFLAGS) $(VORBIS_LIBS) $(VORBIS_DEP_LIBS) -out:$@ @<<
$(EX_DECODER_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\vorbis-ex-encoder.exe: $(VORBIS_LIBS) $(CFG)\$(PLAT)\vorbis-ex $(EX_ENCODER_OBJ)
	link $(LDFLAGS) $(VORBIS_LIBS) $(VORBIS_DEP_LIBS) -out:$@ @<<
$(EX_ENCODER_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\vorbis-ex-seeking.exe: $(VORBIS_LIBS) $(CFG)\$(PLAT)\vorbis-ex $(EX_SEEKING_OBJ)
	link $(LDFLAGS) $(VORBIS_LIBS) $(VORBIS_DEP_LIBS) -out:$@ @<<
$(EX_SEEKING_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\vorbis-ex-vorbisfile.exe: $(VORBIS_LIBS) $(CFG)\$(PLAT)\vorbis-ex $(EX_VORBISFILE_OBJ)
	link $(LDFLAGS) $(VORBIS_LIBS) $(VORBIS_DEP_LIBS) -out:$@ @<<
$(EX_VORBISFILE_OBJ)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1
	
$(CFG)\$(PLAT)\vorbis-test.exe: $(VORBIS_LIBS) $(CFG)\$(PLAT)\test $(vorbis_test_OBJS)
	link $(LDFLAGS) $(VORBIS_LIBS) $(VORBIS_DEP_LIBS) -out:$@ @<<
$(vorbis_test_OBJS)
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
	@-del /f /q $(CFG)\$(PLAT)\vorbis-ex\*.obj
	@-del /f /q $(CFG)\$(PLAT)\libvorbis\*.obj
	@-del /f /q vc$(VSVER)0.pdb
	@-rmdir /s /q $(CFG)\$(PLAT)
