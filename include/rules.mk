ASM=ml.exe
ASM_OPTIONS=/nologo
LINK=link16.exe
LINK_OPTIONS=/nologo
RM=if exist $(1) del $(1)

.PRECIOUS: %.obj

%.obj: %.asm
	$(call msg,$@,$^)
	$(ASM) $(ASM_OPTIONS) $(DEFINES) /Fo $@ /c $<

%.bin: %.obj
	$(call msg,$@,$^)
	$(LINK) $(LINK_OPTIONS) $^,$@,,,,
	
%.img:
	$(call msg,$@,$^)
	copy /b $(subst $(space),+,$^) $@
