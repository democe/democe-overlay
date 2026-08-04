# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Terminal workspace manager for AI coding agents (agent multiplexer)"
HOMEPAGE="https://herdr.dev https://github.com/ogulcancelik/herdr"
SRC_URI="
	amd64? ( https://github.com/ogulcancelik/herdr/releases/download/v${PV}/herdr-linux-x86_64 -> herdr-${PV}-linux-x86_64 )
	arm64? ( https://github.com/ogulcancelik/herdr/releases/download/v${PV}/herdr-linux-aarch64 -> herdr-${PV}-linux-aarch64 )
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="test"

QA_PREBUILT="usr/bin/herdr"

S="${WORKDIR}"

src_install() {
	local src
	if use amd64; then
		src="${DISTDIR}/herdr-${PV}-linux-x86_64"
	else
		src="${DISTDIR}/herdr-${PV}-linux-aarch64"
	fi

	newbin "${src}" herdr
}
