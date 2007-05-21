# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eclipse-rcp

KEYWORDS="~x86"
IUSE=""

DEPEND="=dev-java/swt-3*
	=dev-java/icu4j-3.4*
	=dev-java/eclipse-equinox-common-3*
	=dev-java/eclipse-jface-3*"
RDEPEND="${DEPEND}"

RCP_ROOT="org.eclipse.rcp.source_3.2.2.r322_v20070104-8pcviKVqd8J7C1U"
RCP_PACKAGE_DIR="org.eclipse.jface.databinding_1.0.0.I20060605-1400"
RCP_EXTRA_DEPS="swt-3,icu4j-3.4,eclipse-equinox-common-3,eclipse-jface-3"