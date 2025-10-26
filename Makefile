PROJECT_NAME     := belegnr
IDENTIFIER       := de.bjoernalbers.$(PROJECT_NAME)
VERSION          := $(shell git describe --tags | tr -d v)
SCRIPT           := ./belegnr
INSTALL_DIR      := /usr/local/bin
PKGROOT_DIR      := $(shell mktemp -d)
BUILD_DIR        := $(shell mktemp -d)
TEST_DIR         := $(shell mktemp -d)
TEST_FILE        := $(TEST_DIR)/.belegnr
COMPONENT_PKG    := $(BUILD_DIR)/$(PROJECT_NAME).pkg
DISTRIBUTION_PKG := $(PROJECT_NAME).pkg

build: $(DISTRIBUTION_PKG)

install:
	sudo cp -v "$(SCRIPT)" "$(INSTALL_DIR)"

test:
	# Display usage when no option is given.
	$(SCRIPT) | grep -q Usage
	# Display usage with option -h.
	$(SCRIPT) -h | grep -q Usage
	# Abort with invalid option.
	! $(SCRIPT) -x >/dev/null 2>&1
	# Create first Belegnummer when Belegnummerdatei is missing.
	$(SCRIPT) -n -f "$(TEST_FILE)" | grep -q BE-1000
	# Increment Belegnummer.
	$(SCRIPT) -n -f "$(TEST_FILE)" | grep -q BE-1001
	# Copy Belegnummer to macOS clipboard.
	$(SCRIPT) -n -c -f "$(TEST_FILE)"
	pbpaste | grep -q BE-1002
	rm -rf "$(TEST_DIR)"

$(DISTRIBUTION_PKG): $(SCRIPT)
ifndef APPLE_INSTALLER_IDENTITY
$(error APPLE_INSTALLER_IDENTITY is not set)
endif

ifeq ($(strip $(VERSION)),)
$(error No git tag found to determine version)
endif
	mkdir -p "$(PKGROOT_DIR)$(INSTALL_DIR)"
	cp "$(SCRIPT)" "$(PKGROOT_DIR)$(INSTALL_DIR)"
	pkgbuild \
		--identifier "$(IDENTIFIER)" \
		--version "$(VERSION)" \
		--sign "$(APPLE_INSTALLER_IDENTITY)" \
		--quiet \
		--root "$(PKGROOT_DIR)" \
		--install-location / \
		"$(COMPONENT_PKG)"
	productbuild \
		--package "$(COMPONENT_PKG)" \
		--sign "$(APPLE_INSTALLER_IDENTITY)" \
		--quiet \
		"$(DISTRIBUTION_PKG)"
	rm -rf "$(BUILD_DIR)" "$(PKGROOT_DIR)"
	xcrun notarytool submit "$(DISTRIBUTION_PKG)" \
		--keychain-profile "default" \
		--wait
	xcrun stapler staple "$(DISTRIBUTION_PKG)"
	spctl --assess --type install "$(DISTRIBUTION_PKG)"

.PHONY: build install test
