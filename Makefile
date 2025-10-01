rst_file_paths := $(shell find content -name '*.rst')
file_ids := $(patsubst content/%.rst,%,$(rst_file_paths))
pot_file_pat := .build/gettext/%.pot
pot_file_paths := $(patsubst %,$(pot_file_pat),$(file_ids))
po_file_ja_pat := content/locale/ja/LC_MESSAGES/%.po
po_file_ja_paths := $(patsubst %,$(po_file_ja_pat),$(file_ids))
mo_file_ja_pat := content/locale/ja/LC_MESSAGES/%.mo
mo_file_ja_paths := $(patsubst %,$(mo_file_ja_pat),$(file_ids))

debug:
	@echo rst_file_paths: $(rst_file_paths)
	@echo file_ids: $(file_ids)
	@echo pot_file_paths: $(pot_file_paths)
	@echo po_file_ja_paths: $(po_file_ja_paths)

.PHONY: build
build: build.en build.ja

.PHONY: build.en
build.en:
	sphinx-build --builder html content .build/en

.PHONY: build.ja
build.ja:
	sphinx-build --builder html content .build/ja --define language=ja

.PHONY: internationalize.pot
internationalize.pot: $(pot_file_paths)

$(pot_file_paths)&: $(rst_file_paths)
	sphinx-build --builder gettext content .build/gettext

po_file_ja_pat: $(pot_file_pat)
	@mkdir -p $(@D)
	if [ -f $@ ]; then msgmerge --update $@ $<; else cp $< $@; fi

.PHONY: internationalize.mo
internationalize.mo: $(mo_file_ja_paths)

$(mo_file_ja_pat): $(po_file_ja_pat)
	@mkdir -p $(@D)
	msgfmt -o $@ $<

.PHONY: venv.init
venv.init:
	python -m venv .venv

.PHONY: venv.activate
venv.activate:
	# eval "$$(make --silent venv.activate)"
	echo source .venv/bin/activate

.PHONY: venv.deactivate
venv.deactivate:
	# eval "$$(make --silent venv.deactivate)"
	echo deactivate

.PHONY: pip.install
pip.install:
	pip install -r requirements.txt

.PHONY: clean
clean:
	-rm -rf .build
