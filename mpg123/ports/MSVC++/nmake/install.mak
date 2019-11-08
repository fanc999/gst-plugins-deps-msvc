# NMake Makefile snippet for copying the built libraries, utilities and headers to
# a path under $(PREFIX).

install: all
	@if not exist $(PREFIX)\bin\ mkdir $(PREFIX)\bin
	@if not exist $(PREFIX)\lib\ mkdir $(PREFIX)\lib
	@if not exist $(PREFIX)\include\ @mkdir $(PREFIX)\include
	@if exist $(OUT123_LIB:.lib=.dll) copy /b $(OUT123_LIB:.lib=.dll) $(PREFIX)\bin
	@if exist $(OUT123_LIB:.lib=.pdb) copy /b $(OUT123_LIB:.lib=.pdb) $(PREFIX)\bin
	@if exist $(MPG123_LIB:.lib=.dll) copy /b $(MPG123_LIB:.lib=.dll) $(PREFIX)\bin
	@if exist $(MPG123_LIB:.lib=.pdb) copy /b $(MPG123_LIB:.lib=.pdb) $(PREFIX)\bin
	@copy /b $(OUT123_LIB) $(PREFIX)\lib
	@copy /b $(MPG123_LIB) $(PREFIX)\lib
	@for %h in (..\..\..\src\libout123\out123.h ..\mpg123.h ..\..\..\src\libmpg123\mpg123.h.in ..\..\..\src\libmpg123\fmt123.h) do @copy %h $(PREFIX)\include\%~nxh
