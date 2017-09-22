DEFAULT_BACKGROUND=desktop-background

PIXMAPS=$(wildcard pixmaps/*.png)
DESKTOPFILES=$(wildcard *.desktop)

all: build-emblems

build-emblems clean-emblems install-emblems:
	@target=`echo $@ | sed s/-emblems//`; \
	$(MAKE) $$target -C emblems-pardus || exit 1;

clean: clean-grub clean-emblems

install: install-emblems install-local

install-local:
	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	mkdir -p $(DESTDIR)/usr/share/backgrounds
	cd $(DESTDIR)/usr/share/backgrounds && ln -s /usr/share/images/desktop-base/$(DEFAULT_BACKGROUND) default
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
	cd $(DESTDIR)/usr/share/backgrounds && ln -s /usr/share/desktop-base/gray-theme/wallpaper/contents/images/1920x1080.svg Gray.svg


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
	cd $(DESTDIR)/usr/share/backgrounds && ln -s /usr/share/desktop-base/anger-theme/wallpaper/contents/images/1920x1080.svg Anger.svg


	# YellowMountain theme

	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/login
	$(INSTALL) $(wildcard yellowmountain-theme/login/*) $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/wallpaper/contents/images
	$(INSTALL) yellowmountain-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/wallpaper
	$(INSTALL) yellowmountain-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/wallpaper
	$(INSTALL) $(wildcard yellowmountain-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/wallpaper/contents/images/
	$(INSTALL) yellowmountain-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/yellowmountain.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/yellowmountain-theme/wallpaper YellowMountain

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/lockscreen/contents/images
	$(INSTALL) yellowmountain-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/lockscreen
	$(INSTALL) yellowmountain-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/lockscreen
	$(INSTALL) $(wildcard yellowmountain-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/yellowmountain-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/yellowmountain-theme/lockscreen YellowMountainLockScreen


	# Blue theme

	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/blue-theme/login
	$(INSTALL) $(wildcard blue-theme/login/*) $(DESTDIR)/usr/share/desktop-base/blue-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper/contents/images
	$(INSTALL) blue-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper
	$(INSTALL) blue-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper
	$(INSTALL) $(wildcard blue-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/blue-theme/wallpaper/contents/images/
	$(INSTALL) blue-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/blue.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/blue-theme/wallpaper Blue
	cd $(DESTDIR)/usr/share/backgrounds && ln -s /usr/share/desktop-base/blue-theme/wallpaper/contents/images/1920x1080.svg Blue.svg

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen/contents/images
	$(INSTALL) blue-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen
	$(INSTALL) blue-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen
	$(INSTALL) $(wildcard blue-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/blue-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/blue-theme/lockscreen BlueLockScreen

	# Grub
	$(INSTALL) grub/pardus-grub.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/pardus-grub-1920x1080.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/grub_background.sh $(DESTDIR)/usr/share/desktop-base/

include Makefile.inc
