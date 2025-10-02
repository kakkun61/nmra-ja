# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'nmra-ja'
copyright = '2021, the National Model Railroad Association, Inc. and Kazuki Okamoto (岡本和樹)'
author = 'the National Model Railroad Association, Inc. and Kazuki Okamoto (岡本和樹)'

release = '0.1'
version = '0.1.0'

language = 'en'
locale_dirs = ['locale/']
gettext_compact = False

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
]

intersphinx_mapping = {
    'python': ('https://docs.python.org/3/', None),
    'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
}
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_rtd_theme'

# -- Options for EPUB output
epub_show_urls = 'footnote'
