SCRIPT := ./belegnr

test:
	# Display usage when no option is given.
	$(SCRIPT) | grep -q Usage
	# Display usage with option -h.
	$(SCRIPT) -h | grep -q Usage
	# Abort with invalid option.
	! $(SCRIPT) -x >/dev/null 2>&1

.PHONY: test
