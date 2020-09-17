TOPTARGETS := build clean run

SUBDIRS := bin

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -I ..\include -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBDIRS)
