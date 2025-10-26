SCRIPT := ./belegnr

test:
	# Display Usage
	$(SCRIPT) -h | grep -q Usage

.PHONY: test
