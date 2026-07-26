# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="GE-Proton${PV/./-}"  # 11.3 -> GE-Proton11-3

DESCRIPTION="GE-Proton — GloriousEggroll's custom Proton build with extra patches and fixes"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${MY_P}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1+ BSD MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip bindist"

QA_PREBUILT="*"

src_install() {
	dodir /opt/${PN}
	cp -a "${S}"/* "${D}/opt/${PN}/" || die
}

pkg_postinst() {
	elog "GE-Proton installed to /opt/${PN}"
	elog ""
	elog "To use it in Steam, symlink it into your compatibility tools directory:"
	elog "  mkdir -p ~/.steam/steam/compatibilitytools.d"
	elog "  ln -s /opt/${PN} ~/.steam/steam/compatibilitytools.d/${PN}"
	elog ""
	elog "Then restart Steam — GE-Proton will appear in the per-game"
	elog "compatibility tool dropdown under Properties -> Compatibility."
}