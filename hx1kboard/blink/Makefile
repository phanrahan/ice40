NAME = blink

PNR=nextpnr-ice40

DEVICE = hx8k
PACKAGE = ct256

PCF = hx8kboard.pcf

QUIET = -q

all: $(NAME).bin

%.bin: %.asc
	icepack $< $@

%.asc: %.json
	$(PNR) $(QUIET) --$(DEVICE) --package $(PACKAGE) --asc $@ --pcf $(PCF) --json $< 

%.json: %.v
	yosys -p 'synth_ice40 -top main -json $@' $<

upload: $(NAME).bin
	iceprog $<

explain: $(NAME).txt
	icebox_explain $<

clean:
	rm -f *.bin *.asc *.json *.rpt *_chip.v


.PRECIOUS: %.bin %.asc %.json 

.PHONY: all explain install clean
