VPATH=..\src

include tools.mk
include extra.mk
include rules.mk

build: hello.img
	$(call msg,$@,$^)
	
run: build
	bochs.exe -q
	
boot.obj: bpb.inc
boot.obj: DEFINES+=/D WITH_BPB
LINK_OPTIONS+=/tiny
hello.img: boot.bin hello.bin

clean:
	$(call msg,$@,$^)
	$(call RM,*.obj)
	$(call RM,*.map)
	$(call RM,*.bin)
	$(call RM,*.img)

.PHONY: build run clean
