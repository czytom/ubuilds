# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eclipse-rcp

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=dev-java/eclipse-osgi-${SLOT}* =dev-java/eclipse-equinox-common-${SLOT}*"
RDEPEND="${DEPEND}"

RCP_ROOT="org.eclipse.rcp.source_3.3.2.R33x_r20071022-8y8eE9CEV3FspP8HJrY1M2dS"
RCP_PACKAGE_DIR="org.eclipse.core.jobs_3.3.1.R33x_v20070709"
RCP_EXTRA_DEPS="eclipse-osgi-${SLOT},eclipse-equinox-common-${SLOT}"