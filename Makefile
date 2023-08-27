# Usage:
# make            install Night Light
# make remove     uninstall Night Light

SHELL := /bin/bash
repo_dir := $(abspath $(dir $(MAKEFILE_LIST)))
real_user := $(shell logname)
real_user_home := "$(shell getent passwd $(real_user) | cut -d: -f6)"

install: _check_permission
	$(info Installing...)
	@mkdir -p $(real_user_home)/.local/share/applications/
	@mkdir -p $(real_user_home)/.config/autostart/
	@cp $(repo_dir)/nl-switch /usr/local/bin/
	@chown $(real_user):$(real_user) /usr/local/bin/nl-switch
	@cp $(repo_dir)/etc/nl-switch*.svg $(real_user_home)/.local/share/icons/
	@cp $(repo_dir)/etc/nl-switch.desktop $(real_user_home)/.local/share/applications/
	@cp $(repo_dir)/etc/nl-switch-autostart.desktop $(real_user_home)/.config/autostart/

remove: _check_permission
	$(info Removing...)
	@rm -f /usr/local/bin/nl-switch
	@rm -f $(real_user_home)/.local/share/applications/nl-switch.desktop
	@rm -f $(real_user_home)/.config/autostart/nl-switch-autostart.desktop
	@rm -f $(real_user_home)/.local/share/icons/nl-switch*.svg

_check_permission:
	@if [ ! -w /usr/local/bin ]; then \
		printf "\033[1;31mPermission denied\033[m\n"; \
		exit 4; \
	fi

