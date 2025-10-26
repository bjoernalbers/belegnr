SCRIPT := ./belegnr

test:
	# Display usage when no option is given.
	$(SCRIPT) | grep -q Usage
	# Display usage with option -h.
	$(SCRIPT) -h | grep -q Usage

.PHONY: test
