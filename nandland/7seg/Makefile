NAME = 7seg

PNR=nextpnr-ice40

DEVICE = hx1k
PACKAGE = vq100
FREQ = 25

PCF = goboard.pcf

QUIET = -q

all: $(NAME).bin

%.bin: %.asc
	icepack $< $@

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
