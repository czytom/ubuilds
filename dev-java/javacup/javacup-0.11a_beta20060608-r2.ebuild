# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="source doc"
WANT_SPLIT_ANT="true"

inherit java-pkg-2 java-ant-2

DESCRIPTION="CUP Parser Generator for Java"

HOMEPAGE="http://www2.cs.tum.edu/projects/cup/"

# We cannot put the actual SRC_URI because it causes conflicts with Gentoo mirroring system
# No better URI is available, waiting until it hits actual Gentoo mirrors

#SRC_URI="https://www2.in.tum.de/WebSVN/dl.php?repname=CUP&path=/develop/&rev=0&isdir=1"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=virtual/jdk-1.4
	java-virtuals/javadoc"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/ant-core-1.7.0
	java-virtuals/javadoc"

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -name "*.class" -exec rm -f {} \;
	java-ant_rewrite-classpath
}

src_compile() {
	local gentoo_jars="$(java-pkg_getjars ant-core,javadoc)"
	eant -Dgentoo.classpath="${gentoo_jars}"
	rm bin/java-cup-11.jar
	cp dist/java-cup-11a.jar bin/java-cup-11.jar
	eant clean
	einfo "Recompiling with newly generated javacup"
	eant -Dgentoo.classpath="${gentoo_jars}"
	use doc && javadoc -sourcepath src/ java_cup -d javadoc
}

src_install() {
	java-pkg_newjar dist/java-cup-11a.jar
	java-pkg_newjar dist/java-cup-11a-runtime.jar ${PN}-runtime.jar
	java-pkg_register-ant-task

	dodoc changelog.txt || die
	dohtml manual.html || die
	use source && java-pkg_dosrc java/*
	use doc && java-pkg_dojavadoc javadoc

	java-pkg_dolauncher javacup --jar javacup.jar
}
