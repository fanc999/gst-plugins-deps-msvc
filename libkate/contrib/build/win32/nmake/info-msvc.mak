# NMake Makefile portion for displaying config info

BUILD_TYPE = dll

!ifdef STATIC
BUILD_TYPE = static
!endif

!ifdef TOOLS
TOOLS_BUILT = built
!ifdef PNG
PNG_ENABLED = enabled
!else
PNG_ENABLED = disabled
!endif
!else
PNG_ENABLED = N/A
TOOLS_BUILT = not built
!endif

!if "$(CFG)" == "release"
BUILD_TYPE = $(BUILD_TYPE)-release
!else
BUILD_TYPE = $(BUILD_TYPE)-debug
!endif

build-info-libkate:
	@echo.
	@echo =========================
	@echo Configuration for libkate
	@echo =========================
	@echo Tools: $(TOOLS_BUILT)
	@echo PNG support in kateenc: $(PNG_ENABLED)

all-build-info: build-info-libkate
	@echo.
	@echo ----------------
	@echo Other build info
	@echo ----------------
	@echo Build Type: $(BUILD_TYPE)

help:
	@echo.
	@echo ============================
	@echo Building libkate Using NMake
	@echo ============================
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
	@echo OPTION: Optional, may be any of the following, use OPTION=1 to enable,
	@echo unless otherwise noted; multiple OPTION's may be used.  If no OPTION
	@echo is specified, default libkate DLLs are built with the KISS Fast
	@echo Fourier Transform (FFT) and the OggVorbis FFT.
	@echo ======
	@echo TOOLS:
	@echo Build the tools that are supplied with libkate, libogg is
	@echo required.
	@echo.
	@echo PNG:
	@echo Build PNG support for the kateenc tool, valid when TOOLS is
	@echo enabled.  Requires libpng.
	@echo.
	@echo STATIC:
	@echo Build static .lib versions of libkate instead of DLLs.
	@echo ======
	@echo A 'clean' target is supported to remove all generated files, intermediate
	@echo object files and binaries for the specified configuration.
	@echo.
	@echo An 'install' target is supported to copy the build (DLLs, utility programs,
	@echo LIBs, along with the introspection files if applicable) to appropriate
	@echo locations under ^$(PREFIX).
	@echo ======
	@echo.
