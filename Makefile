# Variables
DESTDIR ?=
PREFIX ?= /usr
QS_DIR = /etc/xdg/quickshell
GREETD_DIR = /etc/greetd
LICENSE_DIR = $(PREFIX)/share/licenses/qsgreeter

.PHONY: all install uninstall

all:
	@echo "Nothing to build. Run 'make install' to install files."

install:
	@echo ":: Installing qsgreeter..."

	install -dm755 "$(DESTDIR)$(QS_DIR)/qsgreeter"
	find "qsgreeter" -type f -exec install -Dm644 "{}" "$(DESTDIR)$(QS_DIR)/{}" \;
	find "$(DESTDIR)$(QS_DIR)/qsgreeter" -type d -exec chmod 755 {} +

	@if command -v niri >/dev/null 2>&1; then \
		echo ":: Installed 'qsgreeter-niri.kdl' into $(GREETD_DIR)"; \
		install -Dm644 niri/qsgreeter-niri.kdl $(DESTDIR)$(GREETD_DIR)/qsgreeter-niri.kdl; \
	fi

	@echo ":: Installing license..."
	install -Dm644 LICENSE -t $(DESTDIR)$(LICENSE_DIR)

	@echo ":: Installation finished."
	@echo ":: Run qsgreeter with 'quickshell -c qsgreeter'"

uninstall:
	@echo ":: Removing qsgreeter..."
	rm -rf $(DESTDIR)$(QS_DIR)/qsgreeter
	rm -f $(DESTDIR)$(GREETD_DIR)/qsgreeter-niri.kdl
	rm -rf $(DESTDIR)$(LICENSE_DIR)
	@echo ":: Uninstallation complete."
