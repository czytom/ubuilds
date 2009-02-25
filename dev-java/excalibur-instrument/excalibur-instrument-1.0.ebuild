# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2

HOMEPAGE="http://excalibur.apache.org"
SRC_URI="mirror://apache/avalon/${PN}/source/${P}.zip"

LICENSE="Apache-2.0"
SLOT="1"
IUSE=""
KEYWORDS="~amd64 ~x86"

JAVA_VERSION="1.4"
COMMON_DEPEND="
	=dev-java/avalon-framework-4.1*"

RDEPEND=">=virtual/jre-${JAVA_VERSION}
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-${JAVA_VERSION}
	app-arch/unzip
	${COMMON_DEPEND}"
SRC_DIR="${S}/src"
JAVADOC_DIR="${S}/javadoc"

src_unpack() {
	unpack ${A}
	cd ${S}
	unzip src.zip -d src
	rm -rf *.jar
}

src_compile() {
	mkdir classes || die "Could not create compile output dir"
	ejavac -cp $(java-pkg_getjars avalon-framework-4.1) -d classes $(find ${SRC_DIR} -name "*.java") || die "Compilation failed"
	jar -cf "${S}/${PN}.jar" -C classes . || die "Could not create jar"
	#Generate javadoc
	if use doc ; then
		mkdir "${JAVADOC_DIR}" || die "Could not create javadoc dir"
		cd ${SRC_DIR}
		javadoc -source "${JAVA_VERSION}" -d ${JAVADOC_DIR} $(find "org/apache/excalibur/instrument" -type d | tr '/' '.') || die "Could not create javadoc"
	fi
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc ${JAVADOC_DIR}
	use source && java-pkg_dosrc ${SRC_DIR}/*
}
