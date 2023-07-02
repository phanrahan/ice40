NAME = blink

#PNR=arachne-pnr
PNR=nextpnr-ice40

DEVICE = lp1k
PACKAGE = tq144
FREQ = 12

PCF = icestick.pcf

QUIET = -q

all: $(NAME).bin

%.bin: %.asc
	icepack $< $@
	icebox_vlog $(NAME).asc > $(NAME)_chip.v

%.asc: %.json
	$(PNR) $(QUIET) --$(DEVICE) --package $(PACKAGE) --freq $(FREQ) --asc $@ --pcf $(PCF) --json $< 

%.json: %.v
	yosys $(QUIET) -p 'synth_ice40 -top main -json $@' $<

upload: $(NAME).bin
	iceprog $<

explain: $(NAME).txt
	icebox_explain $<

clean:
	rm -f *.bin *.asc *.json *.rpt *_chip.v


.PRECIOUS: %.bin %.asc %.json 

.PHONY: all explain install clean
