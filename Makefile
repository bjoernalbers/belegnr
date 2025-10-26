SCRIPT := ./belegnr
TEST_DIR := $(shell mktemp -d)
TEST_FILE := $(TEST_DIR)/.belegnr
DEST_DIR := /usr/local/bin

install:
	sudo cp -v "$(SCRIPT)" "$(DEST_DIR)"

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

.PHONY: install test
