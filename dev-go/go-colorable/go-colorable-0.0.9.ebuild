# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/mattn/go-colorable

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm ~arm64"
	EGIT_COMMIT=v${PV}
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Colorable writer for windows"
HOMEPAGE="https://github.com/mattn/go-colorable"
LICENSE="MIT"
SLOT="0"
IUSE=""
DEPEND="dev-go/go-isatty"
RDEPEND="dev-go/go-isatty"
