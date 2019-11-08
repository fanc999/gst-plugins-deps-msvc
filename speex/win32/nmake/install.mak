# NMake Makefile snippet for copying the built libraries, utilities and headers to
# a path under $(PREFIX).

install: all
	@if not exist $(PREFIX)\bin\ mkdir $(PREFIX)\bin
	@if not exist $(PREFIX)\lib\ mkdir $(PREFIX)\lib
	@if not exist $(PREFIX)\include\speex\ @mkdir $(PREFIX)\include\speex
	@for %f in ($(BUILT_TOOLS)) do @copy /b %~dpnf.pdb $(PREFIX)\bin
	@for %f in ($(BUILT_TOOLS)) do @copy /b %f $(PREFIX)\bin
	@if exist $(SPEEX_LIB:.lib=.dll) copy /b $(SPEEX_LIB:.lib=.dll) $(PREFIX)\bin
	@if exist $(SPEEX_LIB:.lib=.pdb) copy /b $(SPEEX_LIB:.lib=.pdb) $(PREFIX)\bin
	@copy /b $(SPEEX_LIB) $(PREFIX)\lib
	@for %h in (..\..\include\speex\*.h) do @copy %h $(PREFIX)\include\speex\%~nxh
