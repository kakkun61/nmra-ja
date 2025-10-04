rst_file_paths := $(shell find content -name '*.rst')
file_ids := $(patsubst content/%.rst,%,$(rst_file_paths))
pot_file_pat := .build/gettext/%.pot
pot_file_paths := $(patsubst %,$(pot_file_pat),$(file_ids))
po_file_ja_pat := content/locale/ja/LC_MESSAGES/%.po
po_file_ja_paths := $(patsubst %,$(po_file_ja_pat),$(file_ids))
mo_file_ja_pat := content/locale/ja/LC_MESSAGES/%.mo
mo_file_ja_paths := $(patsubst %,$(mo_file_ja_pat),$(file_ids))

.PHONY: build
build: build.en build.ja

.PHONY: build.en
build.en:
	sphinx-build --builder html content .build/en

.PHONY: build.ja
build.ja: multilingual.update
	sphinx-build --builder html content .build/ja --define language=ja

.PHONY: serve
serve:
	warp -d .build

$(pot_file_paths)&: $(rst_file_paths)
	sphinx-build --builder gettext content .build/gettext

.PHONY: multilingual.update
multilingual.update: $(po_file_ja_paths)

$(po_file_ja_pat): $(pot_file_pat) FORCE
	@mkdir -p $(@D)
	if [ -f $@ ]; then msgmerge --update --no-wrap $@ $<; else cp $< $@; fi

$(mo_file_ja_pat): $(po_file_ja_pat)
	@mkdir -p $(@D)
	msgfmt -o $@ $<

.PHONY: spellcheck
spellcheck:
	cspell lint .

.PHONY: clean
clean:
	-rm -rf .build

FORCE:
