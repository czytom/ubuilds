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
COMMON_DEPS="
dev-java/ant-core
dev-java/ant-nodeps
dev-java/maven-artifact
dev-java/commons-lang
dev-java/junit
dev-java/maven-artifact-test
dev-java/plexus-component-api
dev-java/plexus-container-default
=dev-java/plexus-utils-1.0.4*
"
DEPEND=">=virtual/jdk-1.4 ${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.4 ${COMMON_DEPS}"

JAVA_MAVEN_CLASSPATH="
ant-core
ant-nodeps
commons-lang
junit
maven-artifact
maven-artifact-test
plexus-component-api
plexus-container-default
plexus-utils-1.0.4
"
JAVA_MAVEN_PROJECTS="
plexus-compiler-api
plexus-compiler-manager
plexus-compiler-test
plexus-compilers/plexus-compiler-csharp
plexus-compilers/plexus-compiler-javac
plexus-compilers/plexus-compiler-jikes
plexus-compilers
"
# please fix aspectj ebuild and make it build before adding aspectj plugin!
#plexus-compilers/plexus-compiler-aspectj

