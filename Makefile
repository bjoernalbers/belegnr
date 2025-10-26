SCRIPT := ./belegnr
TEST_DIR := $(shell mktemp -d)
TEST_FILE := $(TEST_DIR)/.belegnr

test:
	# Display usage when no option is given.
	$(SCRIPT) | grep -q Usage
	# Display usage with option -h.
	$(SCRIPT) -h | grep -q Usage
	# Abort with invalid option.
	! $(SCRIPT) -x >/dev/null 2>&1
	# Create first Belegnummer when Belegnummerdatei is missing.
	$(SCRIPT) -n -f "$(TEST_FILE)" | grep -q BE-1000

.PHONY: test
