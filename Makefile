BUILD_DIR := build

MAIN_DOC := cf-conventions
MAIN_DOC_BUILD_DIR := $(BUILD_DIR)

MAIN_DOC_INC := version toc-extra authors about-authors
MAIN_DOC_INC += ch01 ch02 ch03 ch04 ch05 ch06 ch07 ch08 ch09
MAIN_DOC_INC += appa appb appc appd appe appf appg apph appi appj appk appl
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

# ------------------------------------------------------------
# Tools / commands (override from environment or CLI if needed)
# ------------------------------------------------------------
RUBY ?= ruby
ASCIIDOCTOR ?= asciidoctor
# Use `ruby -S` to locate the executable in a more portable way
# (avoids issues with RubyGems-generated shebangs)
#ASCIIDOCTOR_PDF ?= asciidoctor-pdf
ASCIIDOCTOR_PDF ?= $(RUBY) -S asciidoctor-pdf
PYTHON ?= python3
DOT ?= dot
# ------------------------------------------------------------
# PDF theme used by asciidoctor-pdf
PDF_THEME ?= default-theme-CF-version.yml

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

ifdef CF_FINAL_DATE
DATE_DOCPROD != LC_ALL=C date -u -d "$(CF_FINAL_DATE)" "$(DATE_FORMAT)"
else
DATE_DOCPROD != LC_ALL=C date -u "$(DATE_FORMAT)"
endif

.PHONY: all clean
.PHONY: html pdf 
.PHONY: conventions-html conventions-pdf conventions
.PHONY: conformance-html conformance-pdf conformance
.PHONY: figures authors
.PHONY: check-tools check-tools-html check-tools-pdf
.PHONY: check-tools-ruby check-tools-asciidoctor check-tools-asciidoctor-pdf
.PHONY: check-tools-dot check-tools-python

all:  authors html pdf 
html: conventions-html conformance-html
pdf:  conventions-pdf conformance-pdf
conventions: conventions-html conventions-pdf
conformance: conformance-html conformance-pdf

authors:          check-tools-python about-authors.adoc zenodo.json CITATION.cff
figures:          check-tools-dot    $(addprefix images/, $(MAIN_DOC_IMG_BLD)) 

conventions-html: check-tools-html   figures $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html
conventions-pdf:  check-tools-pdf    figures $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf

conformance-html: check-tools-html   $(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html
conformance-pdf:  check-tools-pdf    $(CONF_DOC_BUILD_DIR)/$(CONF_DOC).pdf


$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html: $(MAIN_DOC).adoc $(MAIN_DOC_INC) $(MAIN_DOC_IMG) | $(MAIN_DOC_BUILD_DIR)
	$(ASCIIDOCTOR) --verbose --trace -a data-uri -a docprodtime="$(DATE_DOCPROD)" ${FINAL_TAG} $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)
#	sed -E -i 's+(See&#160;)(https://cfconventions.org)(&#160;for&#160;further&#160;information.)+\1<a href="\2" target="_blank">\2</a>\3+' $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html

$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf: $(PDF_THEME) $(MAIN_DOC).adoc $(MAIN_DOC_INC) $(MAIN_DOC_IMG) | $(MAIN_DOC_BUILD_DIR)
	$(ASCIIDOCTOR_PDF) --verbose --trace -a docprodtime="$(DATE_DOCPROD)" ${FINAL_TAG} -d book -a pdf-theme=$(PDF_THEME) $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html: $(CONF_DOC_INC) | $(CONF_DOC_BUILD_DIR)
	$(ASCIIDOCTOR) --verbose --trace ${FINAL_TAG} $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).pdf: $(CONF_DOC_INC) | $(CONF_DOC_BUILD_DIR)
	$(ASCIIDOCTOR_PDF) --verbose --trace ${FINAL_TAG} -d book $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

about-authors.adoc: authors.adoc scripts/update_authors.py
	$(PYTHON) scripts/update_authors.py --authors-adoc=authors.adoc --write-about-authors=about-authors.adoc

zenodo.json: authors.adoc scripts/update_authors.py
	$(PYTHON) scripts/update_authors.py --authors-adoc=authors.adoc --update-zenodo=zenodo.json

CITATION.cff: authors.adoc scripts/update_authors.py
	$(PYTHON) scripts/update_authors.py --authors-adoc=authors.adoc --update-citation=CITATION.cff
  
$(BUILD_DIR):
	mkdir -vp $(BUILD_DIR)

clean:
	rm -rvf $(BUILD_DIR)

#Rules to build non-static images. See MAIN_DOC_IMG_BLD above
images/cfdm_cf_concepts.svg: images/cfdm_cf_concepts.gv
	$(DOT) -Tsvg $< -o $@

images/cfdm_coordinate_reference.svg: images/cfdm_coordinate_reference.gv
	$(DOT) -Tsvg $< -o $@

images/cfdm_coordinates.svg: images/cfdm_coordinates.gv
	$(DOT) -Tsvg $< -o $@

images/cfdm_field.svg: images/cfdm_field.gv
	$(DOT) -Tsvg $< -o $@

# ------------------------------------------------------------

# Tool checks
check-tools:
	@fail=0; \
	for t in check-tools-ruby check-tools-asciidoctor check-tools-dot check-tools-asciidoctor-pdf check-tools-python; do \
	  echo "== $$t =="; \
	  if $(MAKE) -s $$t; then \
	    echo "== OK"; \
	  else \
	    echo "== FAIL"; \
	    fail=1; \
	  fi; \
	  echo ""; \
	done; \
	if [ $$fail -ne 0 ]; then \
	  echo "ERROR: one or more required tools checks failed."; \
	  exit 1; \
	fi

check-tools-html: check-tools-ruby check-tools-asciidoctor check-tools-dot

check-tools-pdf: check-tools-html check-tools-asciidoctor-pdf


check-tools-ruby:
	@command -v $(word 1,$(RUBY)) >/dev/null 2>&1 || { \
	  echo "ERROR: ruby not found."; \
	  echo "       Install it via apt (e.g. apt install ruby) or conda-forge."; \
	  exit 1; }
	@$(RUBY) -v >/dev/null 2>&1 || { \
	  echo "ERROR: ruby not runnable."; exit 1; }

check-tools-asciidoctor:
	@command -v $(word 1,$(ASCIIDOCTOR)) >/dev/null 2>&1 || { \
	  echo "ERROR: asciidoctor not found."; \
	  echo "       Install it via apt (e.g. apt install asciidoctor), conda-forge, or RubyGems."; \
	  echo "       RubyGems: gem install asciidoctor"; \
	  exit 1; }
	@$(ASCIIDOCTOR) -V >/dev/null 2>&1 || { \
	  echo "ERROR: asciidoctor not runnable."; exit 1; }

check-tools-asciidoctor-pdf:
	@$(ASCIIDOCTOR_PDF) -V >/dev/null 2>&1 || { \
	  echo "ERROR: asciidoctor-pdf not found."; \
	  echo "       Install it via apt (e.g. apt install asciidoctor-pdf)"; \
	  echo "       or via RubyGems: gem install asciidoctor-pdf"; \
	  exit 1; }

check-tools-dot:
	@command -v $(word 1,$(DOT)) >/dev/null 2>&1 || { \
	  echo "ERROR: dot (graphviz) not found."; \
	  echo "       Install it via apt (e.g. apt install graphviz) or conda-forge."; \
	  exit 1; }
	@$(DOT) -V >/dev/null 2>&1 || { \
	  echo "ERROR: dot not runnable."; exit 1; }

check-tools-python:
	@command -v $(word 1,$(PYTHON)) >/dev/null 2>&1 || { \
	  echo "ERROR: python not found."; \
	  echo "       Install it via apt (e.g. apt install python3) or conda-forge."; \
	  exit 1; }
	@$(PYTHON) -V >/dev/null 2>&1 || { \
	  echo "ERROR: python not runnable."; exit 1; }

# ------------------------------------------------------------

