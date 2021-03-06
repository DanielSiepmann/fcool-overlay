# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-5.0.2.ebuild,v 1.3 2012/01/25 19:41:30 jer Exp $

EAPI=2

PACK=libchipcard-5.0.3beta
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=02&release=27&file=01&dummy=${PACK}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples"

RDEPEND=">=sys-libs/gwenhywfar-4.2.1
	>=sys-apps/pcsc-lite-1.6.2
	sys-libs/zlib
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )"

src_prepare() {
	S=${S}beta
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable doc full-doc) \
		--with-docpath=/usr/share/doc/${PF}/apidoc
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO \
		doc/{CERTIFICATES,CONFIG,IPCCOMMANDS}

	if use examples; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README
	fi

	find "${D}" -name '*.la' -exec rm -f {} +
}
