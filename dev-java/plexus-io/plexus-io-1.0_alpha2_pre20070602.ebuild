# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_MAVEN_BOOTSTRAP="Y"
inherit java-maven-2

DESCRIPTION="The Plexus project provides a full software stack for creating and executing software projects."
HOMEPAGE="http://plexus.codehaus.org/"

SRC_URI="http://dev.gentooexperimental.org/~kiorky/${P}.tar.bz2"

LICENSE="as-is" # http://plexus.codehaus.org/plexus-utils/license.html
SLOT="0"
KEYWORDS="~x86"
IUSE="source doc"
DEP="
dev-java/plexus-component-api
=dev-java/plexus-container-default-1.0_alpha9
dev-java/plexus-utils
"
DEPEND=">=virtual/jdk-1.4 	${DEP}"
RDEPEND=">=virtual/jre-1.4	${DEP}"

EANT_EXTRA_FLAGS="-Dproject.name=${PN}"
JAVA_MAVEN_CLASSPATH="
plexus-component-api
plexus-container-default-1.0_alpha9
plexus-utils
"
