# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PN="${PN#php-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION=" PHP Static Analysis Tool - discover bugs in your code without running it!"
HOMEPAGE="https://github.com/phpstan/phpstan"
SRC_URI="https://github.com/phpstan/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( >=dev-php/phpunit-6 )"
RDEPEND="dev-lang/php:*[cli]"

# Can go if we ever drop the "PEAR-" prefix.
S="${WORKDIR}/${MY_P}"

# DOCS=( README.md )
# src_install() {
# 	insinto "/usr/share/${PN}"
# 	doins -r phpstan phpstan.php
#
# 	# These load code via relative paths, so they have to be symlinked
# 	# and not dobin'd.
# 	exeinto "/usr/share/${PN}/scripts"
# 	doexe "scripts/phpstan"
# 	dosym "/usr/share/${PN}/scripts/phpstan" "/usr/bin/phpstan"
#
# 	einstalldocs
# }
#
# # The test suite isn't part of the tarball at the moment, keep an eye on
# # https://github.com/squizlabs/PHP_CodeSniffer/issues/548
RESTRICT=test
src_test() {
	phpunit || die "test suite failed"
}
