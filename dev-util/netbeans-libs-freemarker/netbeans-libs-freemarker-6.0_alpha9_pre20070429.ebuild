# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WANT_ANT_TASKS="ant-nodeps"
inherit java-pkg-2 java-ant-2
MY_PV=${PV/_alpha/-m}
DESCRIPTION="Netbeans pseudo-modules"
HOMEPAGE="http://libs.netbeans.org/"
SRC_URI="http://dev.gentoo.org/~fordfrog/distfiles/netbeans-nbbuild-${MY_PV}.tar.bz2
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-libs-${MY_PV}.tar.bz2"
LICENSE="CDDL"
SLOT="6.0"
KEYWORDS="~x86"
COMMON_DEPEND="=dev-util/netbeans-lib-jsr223-${SLOT}*"
DEPEND=">=virtual/jdk-1.5
	=dev-util/netbeans-nbbuild-${SLOT}*
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"
JAVA_PKG_BSFIX="off"

S="${WORKDIR}/netbeans-src"

src_unpack() {
	unpack ${A}
	cd ${S}
	java-pkg_jar-from --build-only --into ${S}/nbbuild netbeans-nbbuild-${SLOT}
	mkdir -p ${S}/nbbuild/netbeans/platform7/modules
	java-pkg_jar-from --into ${S}/nbbuild/netbeans/platform7/modules netbeans-jsr223-${SLOT}
}

src_compile() {
	ANT_TASKS="netbeans-nbbuild-6.0 ant-nodeps" eant -f libs/freemarker/build.xml netbeans -Ddo-not-rebuild-clusters=true
}

src_install() {
	java-pkg_dojar nbbuild/netbeans/ide8/modules/*.jar
	insinto /usr/share/${PN}-${SLOT}/lib/config
	doins nbbuild/netbeans/ide8/config/Modules/*
	insinto /usr/share/${PN}-${SLOT}/lib/update_tracking
	doins nbbuild/netbeans/ide8/update_tracking/*
}
