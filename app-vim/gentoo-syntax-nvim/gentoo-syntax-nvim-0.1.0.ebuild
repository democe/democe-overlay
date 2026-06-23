# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tree-sitter powered Gentoo syntax highlighting for Neovim"
HOMEPAGE="https://github.com/democe/gentoo-syntax-nvim"
SRC_URI="https://github.com/democe/gentoo-syntax-nvim/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="vim MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-util/tree-sitter-cli-0.22
"
RDEPEND="
	>=app-editors/neovim-0.10
"

src_prepare() {
	sed -i 's/| check-submodules//' Makefile
	default
}

src_compile() {
	emake -j1 TREE_SITTER_CACHE="${T}/tree-sitter-cache" build
}

src_test() {
	emake -j1 TREE_SITTER_CACHE="${T}/tree-sitter-cache" test
}

src_install() {
	insinto /usr/share/nvim/site/parser
	doins parser/*.so

	insinto /usr/share/nvim/site/queries
	doins -r queries/*

	insinto /usr/share/nvim/site/lua
	doins -r lua/*

	insinto /usr/share/nvim/site/plugin
	doins plugin/*.lua

	dodoc README.md
}
