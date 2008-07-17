# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/jubler/jubler-3.9.0.ebuild,v 1.2 2008/06/13 20:08:17 serkan Exp $

inherit gnome2 subversion eutils java-pkg-2 java-ant-2 toolchain-funcs

MY_PN=${PN/#j/J}
DESCRIPTION="Java subtitle editor"
HOMEPAGE="http://www.jubler.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mplayer nls spell"

RDEPEND=">=virtual/jre-1.5
	>=media-video/ffmpeg-0.4.9_p20080326
	mplayer? ( media-video/mplayer )
	spell?
	(
		app-text/aspell
		>=dev-java/zemberek-2.0
	)"

DEPEND=">=virtual/jdk-1.5
	media-video/ffmpeg
	app-text/docbook-sgml-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

#S=${WORKDIR}/${MY_PN}-${PV}

ESVN_REPO_URI="http://jubler.svn.sourceforge.net/svnroot/jubler/src"

pkg_setup() {
	if use spell && ! built_with_use dev-java/zemberek linguas_tr; then
		die "Zemberek should be built with Turkish language support"
	fi
	if use mplayer && ! built_with_use media-video/mplayer srt; then
		msg="media-video/mplayer needs to be built with the srt use flag"
		eerror ${msg}
		die ${msg}
	fi
	java-pkg-2_pkg_setup
}

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${P}.patch"
	chmod +x resources/installers/linux/iconinstall
}

src_compile() {
	java-pkg_filter-compiler ecj-3.2
	eant version-update $(use nls && echo i18n) jar faq || die "eant failed"
	cp -v dist/help/jubler-faq.html build/classes/help || die "cp failed"
	cd resources/ffdecode || die
	NOSTRIP=true emake linuxdyn || die "make failed"
}

src_install() {
	java-pkg_dojar dist/Jubler.jar
	use spell && java-pkg_register-dependency zemberek zemberek2-cekirdek.jar
	use spell && java-pkg_register-dependency zemberek zemberek2-tr.jar
	java-pkg_doso resources/ffdecode/libffdecode.so
	doicon resources/installers/linux/jubler.png
	domenu resources/installers/linux/jubler.desktop

	DESTDIR="${D}" eant linuxdesktopintegration
	rm -vr "${D}/usr/share/menu" || die

	java-pkg_dolauncher jubler --main com.panayotis.jubler.Main
	doman resources/installers/linux/jubler.1
	insinto /usr/share/jubler/help
	doins dist/help/*
}

pkg_preinst() {
	gnome2_pkg_preinst
	subversion_pkg_preinst
}
