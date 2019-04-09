GRUB_THEMES=optimum-theme/grub\
	runner-theme/grub
DEFAULT_BACKGROUND=desktop-background

PIXMAPS=$(wildcard pixmaps/*.png)
DESKTOPFILES=$(wildcard *.desktop)

.PHONY: all clean install install-local
all: build-grub build-emblems build-logos
clean: clean-grub clean-emblems clean-logos

.PHONY: build-grub clean-grub install-grub
build-grub clean-grub install-grub:
	@target=`echo $@ | sed s/-grub//`; \
	for grub_theme in $(GRUB_THEMES) ; do \
		if [ -f $$grub_theme/Makefile ] ; then \
			$(MAKE) $$target -C $$grub_theme || exit 1; \
		fi \
	done

.PHONY: build-emblems clean-emblems install-emblems
build-emblems clean-emblems install-emblems:
	@target=`echo $@ | sed s/-emblems//`; \
	$(MAKE) $$target -C emblems-pardus || exit 1;

.PHONY: build-logos clean-logos install-logos
build-logos clean-logos install-logos:
	@target=`echo $@ | sed s/-logos//`; \
	$(MAKE) $$target -C pardus-logos || exit 1;


install: install-grub install-emblems install-logos install-local

install-local:
	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	cd $(DESTDIR)/usr/share/images/desktop-base && ln -s $(DEFAULT_BACKGROUND) default
	# desktop files
	mkdir -p $(DESTDIR)/usr/share/desktop-base
	$(INSTALL_DATA) $(DESKTOPFILES) $(DESTDIR)/usr/share/desktop-base/
	# pixmaps files
	mkdir -p $(DESTDIR)/usr/share/pixmaps
	$(INSTALL_DATA) $(PIXMAPS) $(DESTDIR)/usr/share/pixmaps/

	# Create a 'debian-theme' symlink in plymouth themes folder, pointing at the
	# plymouth theme for the currently active 'desktop-theme' alternative.
	mkdir -p $(DESTDIR)/usr/share/plymouth/themes
	ln -s ../../desktop-base/active-theme/plymouth $(DESTDIR)/usr/share/plymouth/themes/debian-theme

	# Set Plasma 5/KDE default wallpaper
	install -d $(DESTDIR)/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates
	$(INSTALL_DATA) defaults/plasma5/desktop-base.js $(DESTDIR)/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/

	# Xfce 4.6
	mkdir -p $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml
	$(INSTALL_DATA) $(wildcard profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml/*) $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml

	# GNOME background descriptors
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties


	# Runner theme (Onyedi's default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/runner
	$(INSTALL_DATA) $(wildcard runner-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/runner
	install -d $(DESTDIR)/usr/share/desktop-base/runner-theme
	cd $(DESTDIR)/usr/share/desktop-base/runner-theme && ln -s /usr/share/plymouth/themes/runner plymouth
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/runner-theme/login
	$(INSTALL_DATA) $(wildcard runner-theme/login/*) $(DESTDIR)/usr/share/desktop-base/runner-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/runner-theme/wallpaper/contents/images
	$(INSTALL_DATA) runner-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/runner-theme/wallpaper
	$(INSTALL_DATA) runner-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/runner-theme/wallpaper
	$(INSTALL_DATA) $(wildcard runner-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/runner-theme/wallpaper/contents/images/
	$(INSTALL_DATA) runner-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/pardus-runner.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/runner-theme/wallpaper Runner

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/runner-theme/lockscreen/contents/images
	$(INSTALL_DATA) runner-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/runner-theme/lockscreen
	$(INSTALL_DATA) runner-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/runner-theme/lockscreen
	$(INSTALL_DATA) $(wildcard runner-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/runner-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/runner-theme/lockscreen RunnerLockScreen

	# Optimum theme (Ondokuz's default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/optimum
	$(INSTALL_DATA) $(wildcard optimum-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/optimum
	install -d $(DESTDIR)/usr/share/desktop-base/optimum-theme
	cd $(DESTDIR)/usr/share/desktop-base/optimum-theme && ln -s /usr/share/plymouth/themes/optimum plymouth
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/optimum-theme/login
	$(INSTALL_DATA) $(wildcard optimum-theme/login/*) $(DESTDIR)/usr/share/desktop-base/optimum-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/optimum-theme/wallpaper/contents/images
	$(INSTALL_DATA) optimum-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/optimum-theme/wallpaper
	$(INSTALL_DATA) optimum-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/optimum-theme/wallpaper
	$(INSTALL_DATA) $(wildcard optimum-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/optimum-theme/wallpaper/contents/images/
	$(INSTALL_DATA) optimum-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/pardus-optimum.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/optimum-theme/wallpaper Optimum

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/optimum-theme/lockscreen/contents/images
	$(INSTALL_DATA) optimum-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/optimum-theme/lockscreen
	$(INSTALL_DATA) optimum-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/optimum-theme/lockscreen
	$(INSTALL_DATA) $(wildcard optimum-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/optimum-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/optimum-theme/lockscreen OptimumLockScreen


include Makefile.inc
