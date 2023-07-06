NAME = blink

PNR=nextpnr-ice40

DEVICE = up5k
PACKAGE = sg48
FREQ = 12

PCF = upduino_v2.pcf

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
	rm -f *.bin *.asc *.json *.rpt


.PRECIOUS: %.bin %.asc %.json 

.PHONY: all explain install clean
