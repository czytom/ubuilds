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
IUSE="source"
#=dev-java/plexus-container-default-1.0_alpha14
#=dev-java/plexus-component-api-1.0_alpha14
DEP="
dev-java/plexus-container-default
dev-java/plexus-component-api
dev-java/ant-core
dev-java/plexus-utils
dev-java/bsh
dev-java/plexus-classworlds"
DEPEND=">=virtual/jdk-1.4 ${DEP}"
RDEPEND=">=virtual/jre-1.4 ${DEP}"
#plexus-container-default-1.0_alpha14
#plexus-component-api-1.0_alpha14
JAVA_MAVEN_CLASSPATH="
plexus-container-default
plexus-component-api
ant-core
plexus-utils
bsh
plexus-classworlds
"
JAVA_MAVEN_PROJECTS="
plexus-ant-factory
plexus-bsh-factory
"
# in case, we ll need to add  them
#plexus-groovy-factory
#plexus-jruby-factory
#plexus-judo-factory
#plexus-jython-factory
#plexus-marmalade-factory
