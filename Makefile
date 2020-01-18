FONTDIR=/usr/share/fonts/X11/misc

ifeq ($(INDEX),true)
RULE_INDEX=index
else
RULE_INDEX=noindex
endif

fonts: kakwafont-12-b.pcf.gz kakwafont-12-n.pcf.gz kakwafont-12-n.psf


%.pcf.gz: %.bdf
	bdftopcf $^ | gzip > $@

%.psf: %.bdf
	bdf2psf --fb $^ /usr/share/bdf2psf/standard.equivalents /usr/share/bdf2psf/ascii.set+powerline.set 512 $@


index:
	mkfontdir $(DESTDIR)/$(FONTDIR)/
	-xset fp rehash

noindex:

install-fonts: fonts
	mkdir -p $(DESTDIR)/$(FONTDIR)/
	install -m644 *.pcf.gz $(DESTDIR)/$(FONTDIR)/
	install -m644 *.psf $(DESTDIR)/$(FONTDIR)/

install: install-fonts $(RULE_INDEX)

