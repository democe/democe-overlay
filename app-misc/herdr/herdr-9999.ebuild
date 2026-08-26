# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

ZIG_SLOT="0.15"

inherit cargo git-r3 zig-utils

DESCRIPTION="Terminal workspace manager for AI coding agents (agent multiplexer)"
HOMEPAGE="https://herdr.dev https://github.com/herdrdev/herdr"
EGIT_REPO_URI="https://github.com/herdrdev/herdr.git"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-3.0"
SLOT="0"

BDEPEND="
	~dev-lang/zig-0.15.2
"

QA_FLAGS_IGNORED="usr/bin/herdr"

pkg_setup() {
	rust_pkg_setup
	zig-utils_setup
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	export ZIG="${ZIG_EXE}"
	export ZIG_GLOBAL_CACHE_DIR="${T}/zig-global-cache"
	export ZIG_LOCAL_CACHE_DIR="${T}/zig-local-cache"
	cargo_src_compile
}

src_install() {
	cargo_src_install
	dodoc README.md
}
