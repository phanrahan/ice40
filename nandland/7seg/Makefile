NAME = 7seg

#PNR=arachne-pnr
PNR=nextpnr-ice40

DEVICE = hx1k
PACKAGE = vq100
FREQ = 25

PCF = goboard.pcf

QUIET = -q

all: $(NAME).bin

%.bin: %.asc
	icepack $< $@
	icebox_vlog $(NAME).asc > $(NAME)_chip.v

%.asc: %.json
	$(PNR) $(QUIET) --$(DEVICE) --package $(PACKAGE) --freq $(FREQ) --asc $@ --pcf $(PCF) --json $< 

%.json: %.ys
	yosys $<

upload: $(NAME).bin
	iceprog $<

explain: $(NAME).txt
	icebox_explain $<

clean:
	rm -f *.bin *.asc *.json *.rpt *_chip.v


.PRECIOUS: %.bin %.asc %.json 

.PHONY: all explain install clean
