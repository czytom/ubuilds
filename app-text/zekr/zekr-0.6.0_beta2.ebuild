# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

S=${WORKDIR}/${PN}

inherit eutils font java-pkg-2 java-utils-2

DESCRIPTION="An open platform for simply browsing and research on the Holy Quran"
HOMEPAGE="http://siahe.com/zekr/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEPS="dev-java/commons-collections
	 dev-java/commons-configuration
	 =dev-java/commons-io-1*
	 =dev-java/commons-lang-2.1*
	 dev-java/commons-logging
	 dev-java/log4j
	 >=dev-java/swt-3.2.2-r1
	 dev-java/velocity
	 =dev-java/lucene-2*
	 =dev-java/lucene-highlighter-2*"

RDEPEND=">=virtual/jre-1.4
	 ${COMMON_DEPS}"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEPS}"

FONT_SUFFIX="ttf"

pkg_setup() {
	if ! built_with_use -o swt firefox seamonkey xulrunner ; then
		eerror "Re-emerge swt with the 'firefox', 'seamonkey' or 'xulrunner' USE flag"
		die
	fi
	java-pkg-2_pkg_setup
	font_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	unzip -q dist/zekr-src.jar -d src || die
	rm lib/*.jar || die
	rm dist/*.jar || die
	mv res/*.ttf . || die
}

src_compile() {
	cd src || die
	local classpath=$(java-pkg_getjars commons-collections,commons-configuration,commons-io-1,commons-lang-2.1,commons-logging,log4j,swt-3,velocity,lucene-highlighter-2)
	classpath="${classpath}:$(java-pkg_getjar lucene-2 lucene-core.jar)"
	find . -name '*.java'  -print > sources.list
	ejavac -cp ${classpath} @sources.list
  	find . -name '*.class' -print > classes.list
	touch myManifest
	jar cmf myManifest zekr.jar @classes.list
}

src_install() {
	java-pkg_dojar src/zekr.jar
        doicon ${FILESDIR}/zekr.png
        local use_flag=""
        java-pkg_dolauncher zekr \
        	--main net.sf.zekr.ZekrMain \
        	--pwd /usr/share/zekr
        make_desktop_entry zekr "Zekr" zekr.png
        insinto /usr/share/zekr
        doins -r res
        font_src_install
}