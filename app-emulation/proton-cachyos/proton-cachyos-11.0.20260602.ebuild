# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Proton-CachyOS SLR — Gaming-optimized Proton fork with additional patches"
HOMEPAGE="https://github.com/CachyOS/proton-cachyos"
SRC_URI="https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-11.0-20260602-slr/${PN}-11.0-20260602-slr-x86_64_v3.tar.xz"

S="${WORKDIR}/${PN}-11.0-20260602-slr-x86_64_v3"

LICENSE="LGPL-2.1+ BSD MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip bindist"

QA_PREBUILT="*"

src_install() {
	dodir /opt/${PN}
	cp -a "${S}"/* "${D}/opt/${PN}/" || die
}