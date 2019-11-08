# NMake Makefile portion for enabling features for Windows builds

# You may change these lines to customize the .lib files that will be linked to
# (libtheora only depends on libogg)
CFLAGS = $(CFLAGS) /D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /wd4244

# Please do not change anything beneath this line unless maintaining the NMake Makefiles
# Bare minimum features and sources built into Vorbis on Windows
THEORA_DEFINES = /DWIN32 /I..\include
LIBTHEORA_DEFINES = /DTHEORA_EXPORTS $(THEORA_DEFINES)

!if "$(PLAT)" == "Win32"
LIBTHEORA_DEFINES = /DOC_X86_ASM $(LIBTHEORA_DEFINES)
!endif

# Minimal set of libraries needed for the Vorbis DLL
THEORA_DEP_LIBS = ogg.lib

# We build the Vorbis/VorbisEnc/VorbisFile DLL/LIB at least
THEORA_LIB = $(CFG)\$(PLAT)\theora.lib
THEORAENC_LIB = $(CFG)\$(PLAT)\theoraenc.lib
THEORADEC_LIB = $(CFG)\$(PLAT)\theoradec.lib

THEORA_LIBS = $(THEORA_LIB) $(THEORAENC_LIB) $(THEORADEC_LIB)

THEORA_COMMENT_TEST_OBJ = $(CFG)\$(PLAT)\tests\comment.obj
THEORA_GRANULE_TEST_OBJ = $(CFG)\$(PLAT)\tests\granulepos.obj
THEORA_NOOP_TEST_OBJ = $(CFG)\$(PLAT)\tests\noop.obj
THEORA_COMMENT_THEORA_TEST_OBJ = $(CFG)\$(PLAT)\tests\comment_theora.obj
THEORA_GRANULE_THEORA_TEST_OBJ = $(CFG)\$(PLAT)\tests\granulepos_theora.obj
THEORA_NOOP_THEORA_TEST_OBJ = $(CFG)\$(PLAT)\tests\noop_theora.obj

THEORA_TESTS =	\
	$(CFG)\$(PLAT)\comment.exe	\
	$(CFG)\$(PLAT)\comment_theora.exe	\
	$(CFG)\$(PLAT)\granulepos.exe	\
	$(CFG)\$(PLAT)\granulepos_theora.exe	\
	$(CFG)\$(PLAT)\noop.exe	\
	$(CFG)\$(PLAT)\noop_theora.exe

THEORA_EX_SHARED_OBJS =	\
	$(CFG)\$(PLAT)\getopt\getopt.obj	\
	$(CFG)\$(PLAT)\getopt\getopt1.obj

THEORA_EX_DUMP_VIDEO_OBJS =	\
	$(CFG)\$(PLAT)\theora-ex\dump_video.obj	\
	$(THEORA_EX_SHARED_OBJS)

THEORA_EX_DUMP_PSNR_OBJS =	\
	$(CFG)\$(PLAT)\theora-ex\dump_psnr.obj	\
	$(THEORA_EX_SHARED_OBJS)

THEORA_EX_ENCODER_OBJS =	\
	$(CFG)\$(PLAT)\theora-ex\encoder_example.obj	\
	$(THEORA_EX_SHARED_OBJS)

THEORA_EXAMPLES = 	\
	$(CFG)\$(PLAT)\theora-ex-dump-video.exe	\
	$(CFG)\$(PLAT)\theora-ex-dump-psnr.exe	\
	$(CFG)\$(PLAT)\theora-ex-encoder.exe

