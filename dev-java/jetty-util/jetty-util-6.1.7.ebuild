# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ 

inherit eutils java-pkg-2 java-ant-2
DESCRIPTION="A Lightweight Servlet Engine API"
SRC_URI="http://ftp.mortbay.org/pub/jetty-${PV}/jetty-${PV}-src.zip"
HOMEPAGE="http://www.mortbay.org/"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="Apache-1.1"
SLOT="0"

COMMON_DEP=">=dev-java/jetty-servlet-api-2.5"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd jetty-${PV} || die cd failed
	epatch "${FILESDIR}/${PV}/build-jetty-util-${PV}.patch"
	# FIXME : sed the patch instead of before committed
	find . -name '*maven-build*' -exec sed -i \
		-e 's/home\/asura\/\.m2\/repository/usr\/share/g' \
		{} \;
	java-ant_rewrite-classpath modules/util/maven-build.xml
}

EANT_GENTOO_CLASSPATH="jetty-servlet-api"
EANT_BUILD_TARGET="clean compile package"

src_compile() {
	cd jetty-${PV}  || die "cd failed"
	eant package
}

src_install() {
	cd jetty-${PV}
	java-pkg_newjar "modules/util/target/jetty-util-${PV}.jar" jetty-util.jar
}