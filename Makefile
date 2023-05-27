all : html md gmi

html md gmi clean :
	cd dwns.dev; $(MAKE) $@
	cd gogobe.be; $(MAKE) $@
