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
LYCHEE ?= lychee
# ------------------------------------------------------------
# PDF theme used by asciidoctor-pdf
PDF_THEME ?= default-theme-CF-version.yml

TESTS_DIR ?= tests

LYCHEE_TESTS ?= $(TESTS_DIR)/lychee.md
LYCHEE_EXCLUDE ?= --exclude "https://doi.org/10.5281/zenodo.FFFFFF"
LYCHEE_OPTIONS ?= --format markdown --mode plain --require-https --include-fragments --cache --cache-exclude-status '429, 500..600'

# -----------------------------------------------------------------------------
# Build provenance metadata (may be overridden by CI)
# -----------------------------------------------------------------------------
# Semantics:
# - BUILD_CONTEXT=LOCAL | CI
# - BUILD_REF=AUTO            -> best-effort human ref (branch/tag), else "DETACHED"
# - BUILD_REPOSITORY=AUTO     -> remote URL of the current tracking branch (no guessing)
# - BUILD_REVISION=AUTO       -> revision identifier for the build (tag-aware, may include -dirty)
# - BUILD_TIMESTAMP=AUTO      -> UTC ISO 8601 build timestamp
#
# BUILD_REPOSITORY resolution states when AUTO:
# - tracking branch with remote URL  -> <remote-url>
# - local branch without tracking    -> UNTRACKED
# - detached HEAD                    -> DETACHED
# - tracking remote missing URL      -> NO_REMOTE_URL
# -----------------------------------------------------------------------------

BUILD_CONTEXT     ?= LOCAL
BUILD_REF         ?= AUTO
BUILD_REPOSITORY  ?= AUTO
BUILD_REVISION    ?= AUTO
BUILD_TIMESTAMP   ?= AUTO

# Build timestamp (UTC ISO 8601)
ifeq ($(BUILD_TIMESTAMP),AUTO)
  BUILD_TIMESTAMP != LC_ALL=C date -u +%Y-%m-%dT%H:%M:%SZ
endif

# Revision id (tag-aware, includes -dirty when applicable)
ifeq ($(BUILD_REVISION),AUTO)
  BUILD_REVISION != git describe --tags --always --dirty 2>/dev/null || \
                    git rev-parse --short HEAD
endif

# Best-effort ref name for humans (branch or tag). Can be overridden by CI.
ifeq ($(BUILD_REF),AUTO)
  BUILD_REF != git symbolic-ref --quiet --short HEAD 2>/dev/null || \
               git name-rev --name-only --tags --no-undefined HEAD 2>/dev/null || \
               printf '%s\n' "DETACHED"
endif

# Repository provenance: remote URL of the current tracking branch, with explicit states.
ifeq ($(BUILD_REPOSITORY),AUTO)
  BUILD_REPOSITORY != ( \
    BR="$$(git symbolic-ref --quiet --short HEAD 2>/dev/null || true)"; \
    if test -z "$$BR"; then \
      printf '%s\n' "DETACHED"; \
      exit 0; \
    fi; \
    REM="$$(git config --get branch.$$BR.remote 2>/dev/null || true)"; \
    if test -z "$$REM" || test "$$REM" = "."; then \
      printf '%s\n' "UNTRACKED"; \
      exit 0; \
    fi; \
    URL="$$(git remote get-url "$$REM" 2>/dev/null || true)"; \
    if test -z "$$URL"; then \
      printf '%s\n' "NO_REMOTE_URL"; \
      exit 0; \
    fi; \
    printf '%s\n' "$$URL"; \
  )
endif

ASCIIDOCTOR_OPTS += -a build-context=$(BUILD_CONTEXT) \
                    -a build-ref=$(BUILD_REF) \
                    -a build-repository="$(BUILD_REPOSITORY)" \
                    -a build-revision=$(BUILD_REVISION) \
                    -a build-timestamp=$(BUILD_TIMESTAMP)
# ------------------------------------------------------------

# ------------------------------------------------------------
# Public knobs (user-overridable)
# ------------------------------------------------------------

# Editorial state: DRAFT | FINAL | RC
DOC_STATUS ?= DRAFT

# Canonical release date (ISO) is normally read from version.adoc
RELEASE_DATE_ISO ?= $(shell sed -n 's/^:release-date-iso:[[:space:]]*//p' version.adoc | head -n1)

# Visible date formats (GNU date(1) format strings)
ifeq ($(DOC_STATUS),FINAL)
  RELEASE_DATE_FMT ?= +%d&\#160;%B,&\#160;%Y
else
  RELEASE_DATE_FMT ?= +%d&\#160;%B,&\#160;%Y&\#160;%H:%M:%SZ
endif

# Pretty date — DEFAULT computed, but overridable via env/CLI
RELEASE_DATE_TEXT ?= $(shell LC_ALL=C date -u -d "$(RELEASE_DATE_ISO)" "$(RELEASE_DATE_FMT)")

# Year used in citation (only relevant for FINAL, but overridable always)
RELEASE_DATE_YEAR ?= $(shell LC_ALL=C date -u -d "$(RELEASE_DATE_ISO)" '+%Y')

# ------------------------------------------------------------
# Pass attributes to Asciidoctor
# ------------------------------------------------------------

ASCIIDOCTOR_OPTS += \
  -a release-date-text="$(RELEASE_DATE_TEXT)" \
  -a doc-status=$(DOC_STATUS)

# Only pass year if FINAL (or user explicitly set it)
ifeq ($(DOC_STATUS),FINAL)
ASCIIDOCTOR_OPTS += \
  -a release-date-year=$(RELEASE_DATE_YEAR)
endif
# ------------------------------------------------------------


.PHONY: all clean
.PHONY: html pdf 
.PHONY: conventions-html conventions-pdf conventions
.PHONY: conformance-html conformance-pdf conformance
.PHONY: figures authors
.PHONY: check-tools check-tools-html check-tools-pdf
.PHONY: check-tools-ruby check-tools-asciidoctor check-tools-asciidoctor-pdf
.PHONY: check-tools-dot check-tools-python
.PHONY: check-tools-lychee test-links

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
	$(ASCIIDOCTOR) --failure-level=WARN --verbose --trace -a data-uri ${ASCIIDOCTOR_OPTS} $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)
#	sed -E -i 's+(See&#160;)(https://cfconventions.org)(&#160;for&#160;further&#160;information.)+\1<a href="\2" target="_blank">\2</a>\3+' $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html

$(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).pdf: $(PDF_THEME) $(MAIN_DOC).adoc $(MAIN_DOC_INC) $(MAIN_DOC_IMG) | $(MAIN_DOC_BUILD_DIR)
	$(ASCIIDOCTOR_PDF) --failure-level=WARN --verbose --trace -d book -a pdf-theme=$(PDF_THEME) ${ASCIIDOCTOR_OPTS} $(MAIN_DOC).adoc -D $(MAIN_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html: $(CONF_DOC_INC) | $(CONF_DOC_BUILD_DIR)
	$(ASCIIDOCTOR) --failure-level=WARN --verbose --trace ${ASCIIDOCTOR_OPTS} $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

$(CONF_DOC_BUILD_DIR)/$(CONF_DOC).pdf: $(CONF_DOC_INC) | $(CONF_DOC_BUILD_DIR)
	$(ASCIIDOCTOR_PDF) --failure-level=WARN --verbose --trace -d book ${ASCIIDOCTOR_OPTS} $(CONF_DOC).adoc -D $(CONF_DOC_BUILD_DIR)

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
images/%.svg: images/%.gv
	$(DOT) -Tsvg $< -o $@
# ------------------------------------------------------------

# Tests
test-links: check-tools-lychee html
	@mkdir -p $(TESTS_DIR)
	@echo "Checking links with lychee..."
	@$(LYCHEE) $(LYCHEE_OPTIONS) --output $(LYCHEE_TESTS) \
	  $(LYCHEE_EXCLUDE)  \
	  $(MAIN_DOC_BUILD_DIR)/$(MAIN_DOC).html \
	  $(CONF_DOC_BUILD_DIR)/$(CONF_DOC).html; \
	rc=$$?; \
	if [ $$rc -eq 0 ]; then \
	  echo "Link check OK. Report written to $(LYCHEE_TESTS)"; \
	else \
	  echo "Link check FAILED (exit code $$rc). See $(LYCHEE_TESTS) for details."; \
	  exit $$rc; \
	fi

# Tool checks
check-tools:
	@fail=0; \
	for t in check-tools-ruby check-tools-asciidoctor check-tools-dot check-tools-asciidoctor-pdf check-tools-python check-tools-lychee; do \
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

check-tools-lychee:
	@command -v $(word 1,$(LYCHEE)) >/dev/null 2>&1 || { \
	  echo "ERROR: lychee not found."; \
	  echo "       Install it via apt (e.g. apt install lychee), conda-forge, or cargo."; \
	  exit 1; }
	@$(LYCHEE) --version >/dev/null 2>&1 || { \
	  echo "ERROR: lychee not runnable."; exit 1; }

# ------------------------------------------------------------

