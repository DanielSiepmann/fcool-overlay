# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PHP_EXT_NAME="ioncube_loader"
PHP_EXT_ZENDEXT="yes"
PHP_EXT_INI="yes"
DOCS="README.txt LICENSE.txt"

USE_PHP="php5-6 php7-0"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

MY_P="${PN}"
MY_ARCH=${ARCH/amd64/x86-64}

S="${WORKDIR}/ioncube"
PHP_EXT_S=${S}

DESCRIPTION="PHP extension that support for running PHP scripts encoded with ionCube's encoder"
HOMEPAGE="http://www.ioncube.com/"
#SRC_URI="http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_${MY_ARCH}.tar.bz2 -> ioncube_loaders_lin_${MY_ARCH}_${PV}.tar.gz"
SRC_URI="http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_${MY_ARCH}_${PV}.tar.gz"
LICENSE="${PN}"
SLOT="0"
IUSE=""

RESTRICT="nomirror strip"

RDEPEND=""
DEPEND="!dev-php/eaccelerator !dev-php/PECL-apc"

PHP_LIB_DIR="/usr/share/php/${PN}"

pkg_setup() {
    QA_TEXTRELS="${EXT_DIR/\//}/${PHP_EXT_NAME}.so"
    QA_EXECSTACK="${EXT_DIR/\//}/${PHP_EXT_NAME}.so"
}

src_unpack() {
    unpack ${A}
    local slot orig_s="${PHP_EXT_S}"
    for slot in $(php_get_slots); do
        mkdir ${WORKDIR}/${slot}
        php_init_slot_env ${slot}
        versionPart=$(echo ${slot} | cut -c 4-)
        if has_version "dev-lang/php:${PHP_CURRENTSLOT}[threads]"; then
             tsPart="_ts"
        else
             tsPart=""
        fi
        IONCUBE_SO_FILE="${S}/${PHP_EXT_NAME}_lin_${versionPart}${tsPart}.so"
        mkdir modules
        mv ${IONCUBE_SO_FILE} "modules/${PHP_EXT_NAME}.so"

        cp -r "${orig_s}" "${WORKDIR}/${slot}" || die "Failed to copy source ${orig_s} to PHP target directory"
    done

}

src_install() {
#Get from php-ext-source-r2_src_install
	local slot
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}

		# Let's put the default module away
		insinto "${EXT_DIR}"
		newins "modules/${PHP_EXT_NAME}.so" "${PHP_EXT_NAME}.so" || die "Unable to install extension"

		local doc
		for doc in ${DOCS} ; do
			[[ -s ${doc} ]] && dodoc ${doc}
		done
	done
	php-ext-source-r2_createinifiles
}

pkg_config () {
    einfo "Please refer to the installation instructions"
    einfo "in /usr/share/doc/${CATEGORY}/${P}/README."
}

pkg_postinst() {
    # You only need to restart apache2 if you're using mod_php
    if built_with_use =${PHP_PKG} apache2 ; then
        elog
        elog "You need to restart apache2 to activate the ${PN}."
        elog
    fi
}

src_prepare() {
    FOO=bar
}

src_configure() {
    FOO=bar
}

src_compile() {
    FOO=bar
}
