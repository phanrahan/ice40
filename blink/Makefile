NAME = blink

#PNR=arachne-pnr
PNR=nextpnr-ice40

DEVICE = lp1k
PACKAGE = tq144

PCF = $(NAME).pcf

QUIET = -q

all: $(NAME).bin

%.bin: %.asc
	icepack $< $@
	icebox_vlog blink.asc > blink_chip.v

%.asc: %.json
	$(PNR) $(QUIET) --$(DEVICE) --package $(PACKAGE) --asc $@ --pcf $(PCF) --json $< 

%.json: %.ys
	yosys $<

upload: $(NAME).bin
	iceprog $<

explain: $(NAME).txt
	icebox_explain $<

clean:
	rm -f *.bin *.asc *.json *.rpt


.PRECIOUS: %.bin %.asc %.json 

.PHONY: all explain install clean
