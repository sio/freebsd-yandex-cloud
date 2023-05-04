PACKER?=packer
TEMPLATE?=Freebsd.pkr.hcl

ifneq (,$(VERSION))
PACKER_OPTIONS+=-var 'freebsd_version=$(VERSION)'
endif

.PHONY: build fmt
build fmt:
	$(PACKER) $@ $(PACKER_OPTIONS) $(TEMPLATE)

.PHONY: boot
boot:
	./boot.sh

.PHONY: clean
clean:
	$(RM) -rv images/
