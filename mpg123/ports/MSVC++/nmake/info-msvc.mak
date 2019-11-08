# NMake Makefile portion for displaying config info

BUILD_TYPE = dll
ASSEMBLY_OPT = yes
LIBOUT_BACKEND = win32 legacy

!ifdef STATIC
BUILD_TYPE = static
!endif

!ifdef NO_ASM
ASSEMBLY_OPT = no
!endif

!ifdef WASAPI
LIBOUT_BACKEND = win32 WASAPI
!else
!ifdef SDL
LIBOUT_BACKEND = SDL2
!endif
!endif

!if "$(CFG)" == "release"
BUILD_TYPE = $(BUILD_TYPE)-release
!else
BUILD_TYPE = $(BUILD_TYPE)-debug
!endif

build-info-mpg123:
	@echo.
	@echo ===========================
	@echo Configuration for libmpg123
	@echo ===========================
	@echo Assembly optimizations: $(ASSEMBLY_OPT)
	@echo libout backend: $(LIBOUT_BACKEND)

all-build-info: build-info-mpg123
	@echo.
	@echo ----------------
	@echo Other build info
	@echo ----------------
	@echo Build Type: $(BUILD_TYPE)

help:
	@echo.
	@echo ==============================
	@echo Building libmpg123 Using NMake
	@echo ==============================
	@echo nmake /f Makefile.vc CFG=[release^|debug] ^<PREFIX=PATH^> OPTION=1 ...
	@echo.
	@echo Where:
	@echo ------
	@echo CFG: Required, use CFG=release for an optimized build and CFG=debug
	@echo for a debug build.  PDB files are generated for all builds.
	@echo.
	@echo PREFIX: Optional, the path where dependent libraries and tools may be
	@echo found, default is ^$(srcrootdir)\..\vs^$(short_vs_ver)\^$(platform),
	@echo where ^$(short_vs_ver) is 9 for 2008, 12 for VS 2013, 14 for VS 2015
	@echo and so on; and ^$(platform) is Win32 for 32-bit builds and x64 for x64
	@echo builds.  This will also determine where the build results are copied
	@echo when using the 'install' target.
	@echo.
	@echo YASM: Full path to your yasm assembler if not already in your path.
	@echo Required unless NO_ASM (see below) is specified.
	@echo.
	@echo OPTION: Optional, may be any of the following, use OPTION=1 to enable,
	@echo unless otherwise noted; multiple OPTION's may be used.  If no OPTION
	@echo is specified, default libmpg123 and libout123 DLLs are built with the
	@echo assembly optimizations and utilitizes the legacy win32 (winmm) output
	@echo module built into libout123.
	@echo ======
	@echo NO_ASM:
	@echo Do not use assembly optimizations.  Without this option, yasm is
	@echo needed.
	@echo.
	@echo STATIC:
	@echo Build static .lib versions of libmpg123 and libout123 instead of DLLs.
	@echo.
	@echo WASAPI:
	@echo Use WASAPI as the output backend of libout123.  This is taken before
	@echo SDL if SDL is specified.
	@echo.
	@echo SDL:
	@echo Use SDL2 as the output backend of libout123.  WASAPI takes precendence
	@echo over this if both are specified; with neither, the legacy winmm Win32
	@echo backend will be utilized.
	@echo ======
	@echo A 'clean' target is supported to remove all generated files, intermediate
	@echo object files and binaries for the specified configuration.
	@echo.
	@echo An 'install' target is supported to copy the build (DLLs, utility programs,
	@echo LIBs, along with the introspection files if applicable) to appropriate
	@echo locations under ^$(PREFIX).
	@echo ======
	@echo.
