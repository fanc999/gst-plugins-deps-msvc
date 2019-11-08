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

{..\src\libFLAC\}.c{$(CFG)\$(PLAT)\libflac\}.obj::
	$(CC) $(CFLAGS) $(LIBFLAC_BASE_DEFINES) $(LIBFLAC_DLL_DEFINES) /Fo$(CFG)\$(PLAT)\libflac\ /c @<<
$<
<<

{..\src\libFLAC++\}.cpp{$(CFG)\$(PLAT)\libflac++\}.obj::
	$(CXX) $(CFLAGS) /EHsc $(FLAC_BASE_DEFINES) $(LIBFLACPP_DLL_DEFINES) /Fo$(CFG)\$(PLAT)\libflac++\ /c @<<
$<
<<

{..\src\libFLAC\}.c{$(CFG)\$(PLAT)\libflac-static\}.obj::
	$(CC) $(CFLAGS) $(LIBFLAC_BASE_DEFINES) $(LIBFLAC_STATIC_DEFINES) /Fo$(CFG)\$(PLAT)\libflac-static\ /c @<<
$<
<<

{..\src\libFLAC\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(LIBFLAC_BASE_DEFINES) $(LIBFLAC_DLL_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\flac\}.c{$(CFG)\$(PLAT)\flac\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\flac\ /c @<<
$<
<<

{..\src\metaflac\}.c{$(CFG)\$(PLAT)\metaflac\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\metaflac\ /c @<<
$<
<<

{..\src\utils\flacdiff\}.cpp{$(CFG)\$(PLAT)\flacdiff\}.obj::
	$(CXX) $(CFLAGS) /EHsc $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\flacdiff\ /c @<<
$<
<<

{..\src\utils\flactimer\}.cpp{$(CFG)\$(PLAT)\flactimer\}.obj::
	$(CXX) $(CFLAGS) /EHsc $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\flactimer\ /c @<<
$<
<<

{..\examples\c\decode\file\}.c{$(CFG)\$(PLAT)\ex-c-decode\}.obj::
	$(CXX) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\ex-c-decode\ /c @<<
$<
<<

{..\examples\c\encode\file\}.c{$(CFG)\$(PLAT)\ex-c-encode\}.obj::
	$(CXX) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\ex-c-encode\ /c @<<
$<
<<

{..\examples\cpp\decode\file\}.cpp{$(CFG)\$(PLAT)\ex-cpp-decode\}.obj::
	$(CXX) $(CFLAGS) /EHsc $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\ex-cpp-decode\ /c @<<
$<
<<

{..\examples\cpp\encode\file\}.cpp{$(CFG)\$(PLAT)\ex-cpp-encode\}.obj::
	$(CXX) $(CFLAGS) /EHsc $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\ex-cpp-encode\ /c @<<
$<
<<

{..\src\share\getopt\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\share\grabbag\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\share\replaygain_analysis\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\share\replaygain_synthesis\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\share\utf8\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\share\win_utf8_io\}.c{$(CFG)\$(PLAT)\share\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share\ /c @<<
$<
<<

{..\src\test_libs_common\}.c{$(CFG)\$(PLAT)\share-tests\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\share-tests\ /c @<<
$<
<<

{..\src\test_libFLAC\}.c{$(CFG)\$(PLAT)\test-flac\}.obj::
	$(CC) $(CFLAGS) $(FLAC_BASE_DEFINES) $(TEST_FLAC_DEFINES) $(FLAC_ARCH_DEFINES) /Fo$(CFG)\$(PLAT)\test-flac\ /c @<<
$<
<<

{..\src\test_libFLAC++\}.cpp{$(CFG)\$(PLAT)\test-flac++\}.obj::
	$(CXX) $(CFLAGS) /EHsc $(FLAC_BASE_DEFINES) /Fo$(CFG)\$(PLAT)\test-flac++\ /c @<<
$<
<<

{..\src\libFLAC\ia32\}.nasm{$(CFG)\$(PLAT)\libflac\}.obj:
	$(NASM) -f win32 -d OBJ_FORMAT_win32 -i ../src/libFLAC/ia32/ $< -o $@

{..\src\libFLAC\ia32\}.nasm{$(CFG)\$(PLAT)\libflac-static\}.obj:
	$(NASM) -f win32 -d OBJ_FORMAT_win32 -i ../src/libFLAC/ia32/ $< -o $@

# Inference rules for building the test programs
# Used for programs with a single source file.
# Format is as follows
# (all dirs must have a trailing '\'):
#
# {$(srcdir)}.$(srcext){$(destdir)}.exe::
# 	$(CC)|$(CXX) $(cflags) $< /Fo$*.obj  /Fe$@ [/link $(linker_flags) $(dep_libs)]

# Rules for building .lib files
$(FLAC_LIB): $(CFG)\$(PLAT)\flac.dll
$(FLACPP_LIB): $(CFG)\$(PLAT)\flac++.dll

$(FLAC_STATIC_LIB): $(CFG)\$(PLAT)\libflac-static $(CFG)\$(PLAT)\share $(flac_static_OBJS)
	lib $(LDFLAGS_ARCH) $(ARFLAGS) /out:$@ @<<
$(flac_static_OBJS)
<<

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(CFG)\$(PLAT)\flac.dll: $(CFG)\$(PLAT)\libflac $(CFG)\$(PLAT)\share $(flac_dll_OBJS) $(FLAC_WIN32_SHARED_OBJ)
	link /DLL $(LDFLAGS) -out:$@ ogg.lib /PDB:$(@R)_dll.pdb $(flac_dll_OBJS) $(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

$(CFG)\$(PLAT)\flac++.dll: $(FLAC_LIB) $(CFG)\$(PLAT)\libflac++ $(flacpp_dll_OBJS)
	link /DLL $(LDFLAGS) $(FLAC_LIB) -out:$@ @<<
$(flacpp_dll_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flac.exe:	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\flac	\
$(flac_OBJS)	\
$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
$(FLAC_REPLAYGAIN_SYNTHESIS_OBJ)	\
$(flac_grabbag_OBJS)	\
$(FLAC_GETOPT_OBJS)	\
$(FLAC_UTF8_OBJ)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(FLAC_WIN32_SHARED_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) -out:$@ $(flac_OBJS)	\
	$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
	$(FLAC_REPLAYGAIN_SYNTHESIS_OBJ)	\
	$(flac_grabbag_OBJS)	\
	$(FLAC_GETOPT_OBJS)	\
	$(FLAC_UTF8_OBJ)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\iffscan.exe:	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\flac	\
$(iffscan_OBJS)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(FLAC_WIN32_SHARED_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) -out:$@ $(iffscan_OBJS)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\metaflac.exe:	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\metaflac	\
$(metaflac_OBJS)	\
$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
$(flac_grabbag_OBJS)	\
$(FLAC_GETOPT_OBJS)	\
$(FLAC_UTF8_OBJ)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(FLAC_WIN32_SHARED_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) -out:$@ $(metaflac_OBJS)	\
	$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
	$(flac_grabbag_OBJS)	\
	$(FLAC_GETOPT_OBJS)	\
	$(FLAC_UTF8_OBJ)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flacdiff.exe:	\
$(FLACPP_LIB)	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\flacdiff	\
$(FLACDIFF_OBJS)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(FLAC_WIN32_SHARED_OBJ)
	link $(LDFLAGS) $(FLACPP_LIB) $(FLAC_LIB) -out:$@ $(FLACDIFF_OBJS)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flactimer.exe:	\
$(FLACPP_LIB)	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\flactimer	\
$(FLACTIMER_OBJS)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(FLAC_WIN32_SHARED_OBJ)
	link $(LDFLAGS) $(FLACPP_LIB) $(FLAC_LIB) -out:$@ $(FLACTIMER_OBJS)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flac-ex-c-decode-file.exe:	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\ex-c-decode	\
$(EX_C_DEC_FILE_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) -out:$@ $(EX_C_DEC_FILE_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flac-ex-c-encode-file.exe:	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\ex-c-encode	\
$(EX_C_ENC_FILE_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) -out:$@ $(EX_C_ENC_FILE_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flac-ex-cpp-decode-file.exe:	\
$(FLACPP_LIB)	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\ex-cpp-decode	\
$(EX_CPP_DEC_FILE_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) $(FLACPP_LIB) -out:$@ $(EX_CPP_DEC_FILE_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\flac-ex-cpp-encode-file.exe:	\
$(FLACPP_LIB)	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\ex-cpp-encode	\
$(EX_CPP_ENC_FILE_OBJ)
	link $(LDFLAGS) $(FLAC_LIB) $(FLACPP_LIB) -out:$@ $(EX_C_ENC_FILE_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\test-flac.exe: \
$(FLAC_STATIC_LIB)	\
$(CFG)\$(PLAT)\test-flac	\
$(CFG)\$(PLAT)\share-tests	\
$(flac_grabbag_OBJS)	\
$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
$(FLAC_REPLAYGAIN_SYNTHESIS_OBJ)	\
$(TEST_SHARED_OBJS)	\
$(FLAC_UTF8_OBJ)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(test_flac_OBJS)
	link $(LDFLAGS) $(FLAC_STATIC_LIB) -out:$@ \
	$(test_flac_OBJS)	\
	$(flac_grabbag_OBJS)	\
	$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
	$(FLAC_REPLAYGAIN_SYNTHESIS_OBJ)	\
	$(TEST_SHARED_OBJS)	\
	$(FLAC_UTF8_OBJ)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_DEP_LIBS)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

$(CFG)\$(PLAT)\test-flac++.exe: \
$(FLACPP_LIB)	\
$(FLAC_LIB)	\
$(CFG)\$(PLAT)\test-flac++	\
$(CFG)\$(PLAT)\share-tests	\
$(flac_grabbag_OBJS)	\
$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
$(FLAC_REPLAYGAIN_SYNTHESIS_OBJ)	\
$(TEST_SHARED_OBJS)	\
$(FLAC_UTF8_OBJ)	\
$(FLAC_WIN32_UTF8_IO_OBJ)	\
$(FLAC_WIN32_SHARED_OBJ)	\
$(test_flacpp_OBJS)
	link $(LDFLAGS) $(FLACPP_LIB) $(FLAC_LIB) -out:$@ \
	$(test_flacpp_OBJS)	\
	$(flac_grabbag_OBJS)	\
	$(FLAC_REPLAYGAIN_ANALYSIS_OBJ)	\
	$(FLAC_REPLAYGAIN_SYNTHESIS_OBJ)	\
	$(TEST_SHARED_OBJS)	\
	$(FLAC_UTF8_OBJ)	\
	$(FLAC_WIN32_UTF8_IO_OBJ)	\
	$(FLAC_DEP_LIBS)	\
	$(FLAC_WIN32_SHARED_OBJ)
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

# Other .obj files requiring individual attention, that could not be covered by the inference rules.
# Format is as follows (all dirs must have a trailing '\'):
#
# $(obj_file):
# 	$(CC)|$(CXX) $(cflags) /Fo$(obj_destdir) /c @<<
# $(srcfile)
# <<
$(CFG)\$(PLAT)\libflac\lpc_intrin_avx2.obj	\
$(CFG)\$(PLAT)\libflac\stream_encoder_intrin_avx2.obj:
	$(CC) $(CFLAGS) $(LIBFLAC_BASE_DEFINES) $(LIBFLAC_DLL_DEFINES) $(FLAC_AVX_DEFINES) /Fo$@ ..\src\libFLAC\$(@B).c /c

$(CFG)\$(PLAT)\libflac-static\lpc_intrin_avx2.obj	\
$(CFG)\$(PLAT)\libflac-static\stream_encoder_intrin_avx2.obj:
	$(CC) $(CFLAGS) $(LIBFLAC_BASE_DEFINES) $(LIBFLAC_STATIC_DEFINES) $(FLAC_AVX_DEFINES) /Fo$@ ..\src\libFLAC\$(@B).c /c

###

clean:
	@-del /f /q $(CFG)\$(PLAT)\*.lib
	@-del /f /q $(CFG)\$(PLAT)\*.pdb
	@-if exist $(CFG)\$(PLAT)\*.exe.manifest del /f /q $(CFG)\$(PLAT)\*.exe.manifest
	@-del /f /q $(CFG)\$(PLAT)\*.exe
	@-if exist $(CFG)\$(PLAT)\*.dll del /f /q $(CFG)\$(PLAT)\*.dll.manifest
	@-del /f /q $(CFG)\$(PLAT)\*.dll
	@-del /f /q $(CFG)\$(PLAT)\*.ilk
	@-if exist $(CFG)\$(PLAT)\test-flac del /f /q $(CFG)\$(PLAT)\test-flac\*.obj
	@-if exist $(CFG)\$(PLAT)\test-flac++ del /f /q $(CFG)\$(PLAT)\test-flac++\*.obj
	@-del /f /q $(CFG)\$(PLAT)\ex-c-encode\*.obj
	@-del /f /q $(CFG)\$(PLAT)\ex-cpp-decode\*.obj
	@-del /f /q $(CFG)\$(PLAT)\ex-cpp-encode\*.obj
	@-del /f /q $(CFG)\$(PLAT)\flac\*.obj
	@-del /f /q $(CFG)\$(PLAT)\flacdiff\*.obj
	@-del /f /q $(CFG)\$(PLAT)\flactimer\*.obj
	@-del /f /q $(CFG)\$(PLAT)\metaflac\*.obj
	@-del /f /q $(CFG)\$(PLAT)\utils\*.obj
	@-del /f /q $(CFG)\$(PLAT)\share\*.obj
	@-if exist $(CFG)\$(PLAT)\share-tests del /f /q $(CFG)\$(PLAT)\share-tests\*.obj
	@-del /f /q $(CFG)\$(PLAT)\libflac\*.obj
	@-del /f /q $(CFG)\$(PLAT)\libflac++\*.obj
	@-if exist $(CFG)\$(PLAT)\libflac-static del /f /q $(CFG)\$(PLAT)\libflac-static\*.obj
	@-del /f /q vc$(VSVER)0.pdb
	@-rmdir /s /q $(CFG)\$(PLAT)
