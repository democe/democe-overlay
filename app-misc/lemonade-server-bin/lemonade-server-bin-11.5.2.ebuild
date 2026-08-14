# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

# Upstream names the asset after Ubuntu but it is a distro-agnostic,
# dynamically-linked (glibc) build. See:
#   https://github.com/lemonade-sdk/lemonade/releases
# GAIA (amd/gaia) detects Lemonade at the canonical paths this package
# installs: /usr/bin/lemonade (client) and /usr/bin/lemond (daemon).
MY_P="lemonade-embeddable-${PV}-ubuntu-x64"

DESCRIPTION="Local LLM serving with GPU and NPU acceleration server"
HOMEPAGE="https://lemonade-server.ai https://github.com/lemonade-sdk/lemonade"
SRC_URI="amd64? ( https://github.com/lemonade-sdk/lemonade/releases/download/v${PV}/${MY_P}.tar.gz )"

S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip test"

RDEPEND="
	acct-group/lemonade
	acct-user/lemonade
	app-arch/zstd
	dev-libs/openssl
	sys-libs/zlib
	x11-libs/libdrm
"

QA_PREBUILT="usr/bin/lemonade usr/bin/lemond"

src_install() {
	dobin lemonade lemond

	# lemond resolves its resources directory relative to the binary's own
	# location (/usr/bin/resources/), not a share dir. doins -r would nest
	# the dir (…/resources/resources), so copy the contents instead.
	insinto /usr/bin/resources
	doins resources/*

	# daemon state/config dir (env drop-ins, per upstream conf.d layout)
	insinto /etc/lemonade/conf.d
	newins - zz-secrets.conf <<<""

	# systemd service (mirrors the upstream .deb unit)
	systemd_dounit "${FILESDIR}/lemond.service"
	systemd_enable_service multi-user.target lemond.service
}
