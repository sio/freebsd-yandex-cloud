PACKER?=packer
TEMPLATE?=Freebsd.pkr.hcl

.PHONY: build fmt
build fmt:
	$(PACKER) $@ $(TEMPLATE)

.PHONY: boot
boot:
	./boot.sh

.PHONY: clean
clean:
	$(RM) -rv images/
