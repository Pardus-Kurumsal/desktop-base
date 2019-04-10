dir = usr/share/desktop-base/optimum-theme/grub

.PHONY: build clean install

files = \
	grub-4x3.png \
	grub-16x9.png

build: $(files)

clean:
	rm -f grub-4x3.png.raw grub-16x9.png.raw

install:
	install -d $(DESTDIR)/$(dir)
	$(INSTALL_DATA) $(wildcard *.png *.sh) $(DESTDIR)/$(dir)

include ../../Makefile.inc
