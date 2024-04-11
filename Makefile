MAIN_DOC := cf-conventions
MAIN_DOC_INC := version toc-extra 
MAIN_DOC_INC += ch01 ch02 ch03 ch04 ch05 ch06 ch07 ch08 ch09
MAIN_DOC_INC += appa appb appc appd appe appf appg apph appi appj appk
MAIN_DOC_INC += history bibliography
BUILD_DIR := ./conventions_build

.PHONY: all clean
all: $(BUILD_DIR)/$(MAIN_DOC).html

$(BUILD_DIR)/$(MAIN_DOC).html: $(MAIN_DOC).adoc | $(BUILD_DIR)
	asciidoctor --verbose ${FINAL_TAG} -a data-uri -a docprodtime=$(date -u ${DATE_FMT}) $(MAIN_DOC).adoc -D $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -vp $(BUILD_DIR)

clean:
	rm -rvf $(BUILD_DIR)

#for file in *.svg.svg
#do
#  mv "$file" "${file%.svgz}.svg"
#done