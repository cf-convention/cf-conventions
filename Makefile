MAIN_DOC=cf-conventions
MAIN_DOC_INC := toc-extra ch01 ch02 ch03 ch04 ch05 ch06 ch07 ch08 ch09 appa appb appc appd appe appf appg apph appi appj appk history bibliography
BUILD_DIR=./conventions_build

.PHONY: all clean
all: $(MAIN_DOC).html

$(MAIN_DOC).html: $(MAIN_DOC).adoc $(BUILD_DIR)
	asciidoctor --verbose ${FINAL_TAG} -a data-uri -a allow-uri-read -a docprodtime=$(date -u ${DATE_FMT}) $(MAIN_DOC).adoc -D $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

#for file in *.svg.svg
#do
#  mv "$file" "${file%.svg.svg}.svg"
#done