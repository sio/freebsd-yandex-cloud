PACKER?=packer
TEMPLATE?=FreeBSD.pkr.hcl

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

.PHONY: upload
upload: export AWS_ENDPOINT=https://storage.yandexcloud.net
upload: export AWS_EC2_METADATA_DISABLED=true
upload: S3=aws s3 --endpoint-url=$(AWS_ENDPOINT)
upload: S3_PATH=s3://$$S3_BUCKET/freebsd.qcow2
upload:
ifeq (,$(S3_BUCKET))
	$(error Variable not defined: S3_BUCKET)
endif
	$(S3) cp images/freebsd.qcow2 $(S3_PATH)

.PHONY: console
console:
	socat file:`tty`,raw,echo=0 TCP-CONNECT:localhost:2121
