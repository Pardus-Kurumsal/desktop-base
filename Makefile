GRUB_THEMES=grub
DEFAULT_BACKGROUND=desktop-background

PIXMAPS=$(wildcard pixmaps/*.png)
DESKTOPFILES=$(wildcard *.desktop)

all: build-grub build-emblems

build-grub clean-grub install-grub:
	@target=`echo $@ | sed s/-grub//`; \
	for grub_theme in $(GRUB_THEMES) ; do \
		if [ -f $$grub_theme/Makefile ] ; then \
			$(MAKE) $$target -C $$grub_theme || exit 1; \
		fi \
	done$

build-emblems clean-emblems install-emblems:
	@target=`echo $@ | sed s/-emblems//`; \
	$(MAKE) $$target -C emblems-debian || exit 1;

clean: clean-grub clean-emblems

install: install-grub install-emblems install-local

install-local:
	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	cd $(DESTDIR)/usr/share/images/desktop-base && ln -s $(DEFAULT_BACKGROUND) default
	# desktop files
	mkdir -p $(DESTDIR)/usr/share/desktop-base
	$(INSTALL) $(DESKTOPFILES) $(DESTDIR)/usr/share/desktop-base/
	# pixmaps files
	mkdir -p $(DESTDIR)/usr/share/pixmaps
	$(INSTALL) $(PIXMAPS) $(DESTDIR)/usr/share/pixmaps/


	# Set Plasma 5/KDE default wallpaper
	install -d $(DESTDIR)/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates
	$(INSTALL) defaults/plasma5/desktop-base.js $(DESTDIR)/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/

	# Xfce 4.6
	mkdir -p $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml
	$(INSTALL) $(wildcard profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml/*) $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml

	# GNOME background descriptors
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties

	# Plymouth
	install -d $(DESTDIR)/usr/share/plymouth/themes/runner
	$(INSTALL) $(wildcard plymouth/runner/*) $(DESTDIR)/usr/share/plymouth/themes/runner
	cd $(DESTDIR)/usr/share/desktop-base/plymouth/runner && ln -s /usr/share/plymouth/themes/runner plymouth
	$(INSTALL) plymouth/plymouthd.defaults $(DESTDIR)/usr/share/desktop-base/plymouth


	# Gray theme
	
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/gray-theme/login
	$(INSTALL) $(wildcard gray-theme/login/*) $(DESTDIR)/usr/share/desktop-base/gray-theme/login
	
	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/gray-theme/wallpaper/contents/images
	$(INSTALL) gray-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/gray-theme/wallpaper
	$(INSTALL) gray-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/gray-theme/wallpaper
	$(INSTALL) $(wildcard gray-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/gray-theme/wallpaper/contents/images/
	$(INSTALL) gray-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/gray.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/gray-theme/wallpaper Gray


	# Anger theme
	
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/anger-theme/login
	$(INSTALL) $(wildcard anger-theme/login/*) $(DESTDIR)/usr/share/desktop-base/anger-theme/login
	
	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/anger-theme/wallpaper/contents/images
	$(INSTALL) anger-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/anger-theme/wallpaper
	$(INSTALL) anger-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/anger-theme/wallpaper
	$(INSTALL) $(wildcard anger-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/anger-theme/wallpaper/contents/images/
	$(INSTALL) anger-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/anger.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/anger-theme/wallpaper Anger


	# Blue theme
	
	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper/contents/images
	$(INSTALL) blue-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper
	$(INSTALL) blue-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper
	$(INSTALL) $(wildcard blue-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper/contents/images/
	$(INSTALL) blue-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/blue.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/blue-theme/wallpaper Blue

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen/contents/images
	$(INSTALL) blue-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen
	$(INSTALL) blue-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen
	$(INSTALL) $(wildcard blue-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/blue-theme/lockscreen BlueLockScreen

include Makefile.inc
