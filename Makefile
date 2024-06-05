MAIN_DOC := cf-conventions
MAIN_DOC_BUILD_DIR := ./conventions_build

MAIN_DOC_INC := version toc-extra 
MAIN_DOC_INC += ch01 ch02 ch03 ch04 ch05 ch06 ch07 ch08 ch09
MAIN_DOC_INC += appa appb appc appd appe appf appg apph appi appj appk
MAIN_DOC_INC += history bibliography

MAIN_DOC_IMG := NFFFFFF-1.0.png
MAIN_DOC_IMG += ci_1d_interpolation_subarea.svg ci_2d_interpolation_subarea.svg ci_bounds_interpolation.svg
MAIN_DOC_IMG += ci_dimensions_overview.svg ci_interpolation_coefficients.svg ci_interpolation_subarea_generation_process.svg
MAIN_DOC_IMG += ci_quadratic1.svg ci_quadratic2.svg ci_quadratic3.svg mesh_figure.svg

MAIN_DOC_IMG_BLD := cfdm_cf_concepts.svg cfdm_coordinate_reference.svg cfdm_coordinates.svg cfdm_field.svg
MAIN_DOC_IMG_BLD += order_horizontal_bounds__1D_coord_variables.png order_horizontal_bounds__2D_coord_variables.png

MAIN_DOC_IMG += $(MAIN_DOC_IMG_BLD)

CONF_DOC := conformance
CONF_DOC_BUILD_DIR := ./conformance_build
CONF_DOC_INC := version



.PHONY: all clean
all: $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html $(addpreffix images/, $(MAIN_DOC_IMG_BLD)) $(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf

$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html: $(MAIN_DOC).adoc $(addprefix images/, $(MAIN_DOC_IMG)) $(addsuffix .adoc, $(MAIN_DOC_INC)) | $(MAIN_DOC_BUILD_DIR)
	asciidoctor --verbose ${FINAL_TAG} -a data-uri -a docprodtime=$(date -u ${DATE_FMT}) $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)

$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf: $(MAIN_DOC).adoc $(addprefix images/, $(MAIN_DOC_IMG)) $(addsuffix .adoc, $(MAIN_DOC_INC)) | $(MAIN_DOC_BUILD_DIR)
	asciidoctor-pdf --verbose ${FINAL_TAG} -a docprodtime=$(date -u ${DATE_FMT}) -d book -a pdf-theme=default-theme-CF-version.yml --trace $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html: $(CONF_DOC).adoc $(addsuffix .adoc, $(CONF_DOC_INC)) | $(CONF_DOC_BUILD_DIR)
	asciidoctor --verbose ${FINAL_TAG} $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

$(MAIN_DOC_BUILD_DIR):
	mkdir -vp $(MAIN_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR):
	mkdir -vp $(CONF_DOC_BUILD_DIR)

clean:
	rm -rvf $(MAIN_DOC_BUILD_DIR)

images/cfdm_cf_concepts.svg: images/cfdm_cf_concepts.gv
	dot -Tsvg $< -o $@

images/cfdm_coordinate_reference.svg: images/cfdm_coordinate_reference.gv
	dot -Tsvg $< -o $@

images/cfdm_coordinates.svg: images/cfdm_coordinates.gv
	dot -Tsvg $< -o $@

images/cfdm_field.svg: images/cfdm_field.gv
	dot -Tsvg $< -o $@

images/order_horizontal_bounds__1D_coord_variables.png: images/order_horizontal_bounds__1D_coord_variables.pdf
	pdftoppm -progress -singlefile -r 300 -png $< $(basename $@)

images/order_horizontal_bounds__2D_coord_variables.png: images/order_horizontal_bounds__2D_coord_variables.pdf
	pdftoppm -progress -singlefile -r 300 -png $< $(basename $@)
