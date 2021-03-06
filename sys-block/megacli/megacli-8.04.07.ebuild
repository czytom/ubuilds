# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit rpm

DESCRIPTION="LSI Logic MegaRAID Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://dl.dropbox.com/u/167753/lsi/${PV}_MegaCLI.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	app-admin/chrpath"

S="${WORKDIR}"

QA_PRESTRIPPED="/opt/megacli/megacli"

src_unpack() {
	unpack ${A}
	ewarn "${S}"
	cd "${S}"
	unpack ./CLI_Lin_${PV}.zip
	#cd "${S}"
	unpack ./MegaCliLin.zip
	rpm_unpack ./MegaCli-${PV}-1.noarch.rpm
	rpm_unpack ./Lib_Utils-1.00-09.noarch.rpm
}

src_install() {
	exeinto /opt/megacli
	libsysfs=libsysfs.so.2.0.2
	case ${ARCH} in
		amd64) MegaCli=MegaCli64 libsysfs=x86_64/${libsysfs};;
		x86) MegaCli=MegaCli;;
		*) die "invalid ARCH";;
	esac
	newexe opt/MegaRAID/MegaCli/${MegaCli} megacli

	exeinto /opt/megacli/lib
	doexe opt/lsi/3rdpartylibs/${libsysfs}

	into /opt
	newbin "${FILESDIR}"/${PN}-wrapper ${PN}
	dosym ${PN} /opt/bin/MegaCli

	#dodoc ${PV}_MegaCLI.txt
	dodoc readme.txt

	# Remove DT_RPATH
	chrpath -d "${D}"/opt/megacli/megacli
}

pkg_postinst() {
	einfo
	einfo "See /usr/share/doc/${PF}/${PV}_MegaCli.txt for a list of supported controllers"
	einfo "(contains LSI model names only, not those sold by 3rd parties"
	einfo "under custom names like Dell PERC etc)."
	einfo
	einfo "As there's no dedicated manual, you might want to have"
	einfo "a look at the following cheat sheet (originally written"
	einfo "for Dell PowerEdge Expandable RAID Controllers):"
	einfo "http://tools.rapidsoft.de/perc/perc-cheat-sheet.html"
	einfo
	einfo "For more information about working with Dell PERCs see:"
	einfo "http://tools.rapidsoft.de/perc/"
	einfo
}
