NAME = lut

#PNR=arachne-pnr
PNR=nextpnr-ice40

DEVICE = hx1k
PACKAGE = tq144

PCF = hx1kboard.pcf

QUIET = -q

all: $(NAME).bin

%.bin: %.asc
	icepack $< $@
	icebox_vlog $(NAME).asc > $(NAME)_chip.v

%.asc: %.json
	$(PNR) $(QUIET) --$(DEVICE) --package $(PACKAGE) --asc $@ --pcf $(PCF) --json $< 

%.json: %.v
	yosys -p 'synth_ice40 -top top -json $@' $<

upload: $(NAME).bin
	iceprog $<

explain: $(NAME).txt
	icebox_explain $<

clean:
	rm -f *.bin *.asc *.json *.rpt *_chip.v


.PRECIOUS: %.bin %.asc %.json 

.PHONY: all explain install clean
