# NMake Makefile snippet for copying the built libraries, utilities and headers to
# a path under $(PREFIX).

install: all
	@if not exist $(PREFIX)\bin\ mkdir $(PREFIX)\bin
	@if not exist $(PREFIX)\lib\ mkdir $(PREFIX)\lib
	@if not exist $(PREFIX)\include\kate\ @mkdir $(PREFIX)\include\kate
	@if not "$(BUILT_TOOLS)" == "" for %f in ($(BUILT_TOOLS)) do @copy /b %~dpnf.pdb $(PREFIX)\bin
	@if not "$(BUILT_TOOLS)" == "" for %f in ($(BUILT_TOOLS)) do @copy /b %f $(PREFIX)\bin
	@if exist $(KATE_LIB:.lib=.dll) copy /b $(KATE_LIB:.lib=.dll) $(PREFIX)\bin
	@if exist $(KATE_LIB:.lib=.pdb) copy /b $(KATE_LIB:.lib=.pdb) $(PREFIX)\bin
	@copy /b $(KATE_LIB) $(PREFIX)\lib
	@if exist $(KATE_OGG_LIB:.lib=.dll) copy /b $(KATE_OGG_LIB:.lib=.dll) $(PREFIX)\bin
	@if exist $(KATE_OGG_LIB:.lib=.pdb) copy /b $(KATE_OGG_LIB:.lib=.pdb) $(PREFIX)\bin
	@copy /b $(KATE_OGG_LIB) $(PREFIX)\lib
	@for %h in (..\..\..\..\include\kate\*.h) do @copy %h $(PREFIX)\include\kate\%~nxh
