# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit java-pkg-2 java-ant-2

DESCRIPTION="CUP Parser Generator for Java"

HOMEPAGE="http://www2.cs.tum.edu/projects/cup/"
#SRC_URI="https://www2.in.tum.de/WebSVN/dl.php?repname=CUP&path=/develop/&rev=0&isdir=1"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://dev.gentoo.org/~caster/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
KEYWORDS=""
IUSE="doc source"
DEPEND=">=virtual/jdk-1.4
        source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
        unpack ${A}
        cd ${S}
        find . -name "*.class" -exec rm -f {} \;
}

src_compile() {
	ANT_TASKS="none"
	eant
	rm bin/java-cup-11.jar
	cp dist/java-cup-11a.jar bin/java-cup-11.jar	
	eant clean
	einfo "Recompiling with newly generated javacup"
	eant
	use doc && javadoc -sourcepath src/ java_cup -d javadoc
}

src_install() {
	java-pkg_newjar dist/java-cup-11a.jar
	java-pkg_newjar dist/java-cup-11a-runtime.jar ${PN}-runtime.jar
        java-pkg_register-ant-task

        dodoc changelog.txt || die
        dohtml manual.html || die
        use source && java-pkg_dosrc java_cup
	use doc && java-pkg_dojavadoc javadoc
}



