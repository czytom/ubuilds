# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_MAVEN_BOOTSTRAP="Y"
JAVA_MAVEN_ADD_GENERATED_STUFF="Y"

inherit java-maven-2

DESCRIPTION="Maven is a software project management and comprehension tool."
HOMEPAGE="http://maven.apache.org/"
MY_BASE_URL="http://dev.gentooexperimental.org/~kiorky"
SRC_URI="${MY_BASE_URL}/${P}.tar.bz2
${MY_BASE_URL}/${P}-gen-src.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="source doc"
COMMON_DEPS="
dev-java/ant-core
dev-java/ant-junit
dev-java/bsh
=dev-java/doxia-1.0_alpha8*
>dev-java/doxia-1.0_alpha8
=dev-java/easymock-1*
dev-java/junit
dev-java/maven-artifact
dev-java/maven-core
dev-java/maven-model
dev-java/maven-plugin-api
dev-java/maven-plugin-descriptor
dev-java/maven-project
dev-java/maven-settings
dev-java/plexus-archiver
dev-java/plexus-classworlds
dev-java/plexus-compiler
dev-java/plexus-component-api
dev-java/plexus-container-default
dev-java/plexus-utils
dev-java/qdox
dev-java/wagon-provider-api
dev-java/xalan
dev-java/xml-commons
dev-java/maven-reporting
dev-java/commons-validator
=dev-java/asm-3*
"
DEPEND=">=virtual/jdk-1.4 ${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.4 ${COMMON_DEPS}"

JAVA_MAVEN_CLASSPATH="
commons-validator
ant-core
ant-junit
bsh
doxia-1.0_alpha8
doxia
easymock-1
junit
maven-artifact
maven-core
maven-model
maven-plugin-api
maven-plugin-descriptor
maven-project
maven-settings
plexus-archiver
plexus-classworlds
plexus-compiler
plexus-component-api
plexus-container-default
plexus-utils
qdox-1.6
wagon-provider-api
xalan
xml-commons
maven-reporting
asm-3
"
# PLEASE KEEP  THE ORDER !
JAVA_MAVEN_PROJECTS="
maven-reporting-impl
maven-shared-io
file-management
maven-ant
maven-common-artifact-filters
maven-repository-builder
maven-plugin-tools
maven-test-tools
maven-plugin-testing-harness
maven-plugin-tools/maven-plugin-tools-model
maven-plugin-tools/maven-plugin-tools-api
maven-plugin-tools/maven-plugin-tools-java
maven-plugin-tools/maven-plugin-tools-ant
maven-plugin-tools/maven-plugin-tools-beanshell
maven-invoker
maven-shared-monitor
maven-verifier
maven-archiver
maven-dependency-analyzer
maven-enforcer-rule-api
maven-downloader
maven-dependency-tree
maven-plugin-testing-tools
"
JAVA_MAVEN_GENERATED_STUFF_UNPACK_DIR="${S}"
JAVA_MAVEN_PATCHES="${FILESDIR}/plugin-testing-tools.patch"
# NOTE:
# * Be carefull, top pom.xml modules  were broken, i updated it by  hand before tarballing it ...
# for maven parent pom, just kick off the parent node from the pom.xml file!
# Maybe following modules are not neccessary so i dont include them:
# * maven-web-ui-tests #needing selenium / not used so not packaged atm
# * maven-model-converter needs old 2.0 maven-model, if not using it, will not
# package it
# * maven-app-configuration/web maven-app-configuration/model
# maven-app-configuration : need plexus-registry -> lot of deps to add ...
# maven-toolchain dont compile
