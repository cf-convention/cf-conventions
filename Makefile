BUILD_DIR := build

MAIN_DOC := cf-conventions
MAIN_DOC_BUILD_DIR := $(BUILD_DIR)

MAIN_DOC_INC := version toc-extra 
MAIN_DOC_INC += ch01 ch02 ch03 ch04 ch05 ch06 ch07 ch08 ch09
MAIN_DOC_INC += appa appb appc appd appe appf appg apph appi appj appk
MAIN_DOC_INC += history bibliography

MAIN_DOC_INC := $(addsuffix .adoc, $(MAIN_DOC_INC))

#These are the static files for the images of the conventions document
MAIN_DOC_IMG := NFFFFFF-1.0.png
MAIN_DOC_IMG += ci_1d_interpolation_subarea.svg ci_2d_interpolation_subarea.svg ci_bounds_interpolation.svg
MAIN_DOC_IMG += ci_dimensions_overview.svg ci_interpolation_coefficients.svg ci_interpolation_subarea_generation_process.svg
MAIN_DOC_IMG += ci_quadratic1.svg ci_quadratic2.svg ci_quadratic3.svg mesh_figure.svg
MAIN_DOC_IMG += order_horizontal_bounds__1D_coord_variables.svg order_horizontal_bounds__2D_coord_variables.svg

#  ... and th list of dynamic files images, with a build rule that appears below
MAIN_DOC_IMG_BLD := cfdm_cf_concepts.svg cfdm_coordinate_reference.svg cfdm_coordinates.svg cfdm_field.svg

MAIN_DOC_IMG += $(MAIN_DOC_IMG_BLD)

MAIN_DOC_IMG := $(addprefix images/, $(MAIN_DOC_IMG))

CONF_DOC := conformance

CONF_DOC_BUILD_DIR := $(BUILD_DIR)

CONF_DOC_INC := conformance.adoc version.adoc

ifdef CF_FINAL
DATE_FORMAT := +%d&\#160;%B,&\#160;%Y
FINAL_TAG := -a final
else
DATE_FORMAT ?= +%d&\#160;%B,&\#160;%Y&\#160;%H:%M:%SZ
LOCAL_BRANCH=`git name-rev --name-only HEAD`
TRACKING_BRANCH=`git config branch.$LOCAL_BRANCH.merge`
TRACKING_REMOTE=`git config branch.$LOCAL_BRANCH.remote`
REMOTE_URL=`git config remote.$TRACKING_REMOTE.url`
#git config branch.$(git name-rev --name-only HEAD).remote
#git name-rev --name-only HEAD
FINAL_TAG ?= -a draft -a revnumber=v1.12.0-rc7-24-gb724218 -a revremark=${LOCAL_BRANCH}
endif

DATE_DOCPROD != LC_ALL=C date -u "$(DATE_FORMAT)"

.PHONY: all clean images html pdf conventions-html conventions-pdf conventions conformance-html conformance-pdf conformance
all: images html pdf 
images: $(addprefix images/, $(MAIN_DOC_IMG_BLD)) 

conventions-html: $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html
conventions-pdf: $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf
conventions: conventions-html conventions-pdf

conformance-html: $(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html
conformance-pdf: $(CONF_DOC_BUILD_DIR)/$(CONF_DOC).pdf
conformance: conformance-html conformance-pdf

html: conventions-html conformance-html
pdf: conventions-pdf conformance-pdf

$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html: $(MAIN_DOC).adoc $(MAIN_DOC_INC) $(MAIN_DOC_IMG) | $(MAIN_DOC_BUILD_DIR)
	asciidoctor --verbose --trace -a data-uri -a docprodtime="$(DATE_DOCPROD)" ${FINAL_TAG} $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)
	sed -E -i 's+(See&#160;)(https://cfconventions.org)(&#160;for&#160;further&#160;information.)+\1<a href="\2" target="_blank">\2</a>\3+' $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html

$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf: $(MAIN_DOC).adoc $(MAIN_DOC_INC) $(MAIN_DOC_IMG) | $(MAIN_DOC_BUILD_DIR)
	asciidoctor-pdf --verbose --trace -a docprodtime="$(DATE_DOCPROD)" ${FINAL_TAG} -d book -a pdf-theme=default-theme-CF-version.yml $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html: $(CONF_DOC_INC) | $(CONF_DOC_BUILD_DIR)
	asciidoctor --verbose --trace ${FINAL_TAG} $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).pdf: $(CONF_DOC_INC) | $(CONF_DOC_BUILD_DIR)
	asciidoctor-pdf --verbose --trace ${FINAL_TAG} -d book $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

#$(MAIN_DOC_BUILD_DIR):
#	mkdir -vp $(MAIN_DOC_BUILD_DIR)

#$(CONF_DOC_BUILD_DIR):
#	mkdir -vp $(CONF_DOC_BUILD_DIR)

$(BUILD_DIR):
	mkdir -vp $(BUILD_DIR)

clean:
#	rm -rvf $(MAIN_DOC_BUILD_DIR)
#	rm -rvf $(CONF_DOC_BUILD_DIR)
	rm -rvf $(BUILD_DIR)

#Rules to build non-static images. See MAIN_DOC_IMG_BLD above
images/cfdm_cf_concepts.svg: images/cfdm_cf_concepts.gv
	dot -Tsvg $< -o $@

images/cfdm_coordinate_reference.svg: images/cfdm_coordinate_reference.gv
	dot -Tsvg $< -o $@

images/cfdm_coordinates.svg: images/cfdm_coordinates.gv
	dot -Tsvg $< -o $@

images/cfdm_field.svg: images/cfdm_field.gv
	dot -Tsvg $< -o $@