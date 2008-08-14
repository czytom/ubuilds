# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
JAVA_PKG_IUSE="doc javamail jms source test"
inherit java-pkg-2

DESCRIPTION="An easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="http://www.apache.org/dist/avalon/logkit/source/logkit-${PV}-src.tar.gz"
COMMON_DEP="
	=dev-java/avalon-framework-4.1*
	dev-java/sun-jaf
	dev-java/log4j
	=dev-java/servletapi-2.3*
	dev-java/sun-javamail
	dev-java/sun-jms"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	test? ( dev-java/junit:4 )
	${COMMON_DEP}"

LICENSE="Apache-1.1"
SLOT="1.2"
IUSE=""
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"

S="${WORKDIR}/logkit-${PV}-dev"
SRC_DIR="${S}/src/java"
JAVADOC_DIR="${S}/javadoc"

src_compile() {
	mkdir classes || die "Could not create compile output dir"
	ejavac -encoding "ISO-8859-1" -classpath $(java-pkg_getjars sun-jaf,sun-javamail,sun-jms,log4j,servletapi-2.3,avalon-framework-4.1) -d classes $(find ${SRC_DIR} -name "*.java") || die "Compilation failed"
	jar -cf "${S}/${PN}.jar" -C classes . || die "Could not create jar"
	#Generate javadoc
	if use doc ; then
		mkdir "${JAVADOC_DIR}" || die "Could not create javadoc dir"
		cd ${SRC_DIR}
		javadoc -encoding "ISO-8859-1" -sourcepath "${SRC_DIR}" -classpath $(java-pkg_getjars sun-jaf,sun-javamail,sun-jms,log4j,servletapi-2.3,avalon-framework-4.1)  -source "${JAVA_VERSION}" -d ${JAVADOC_DIR} $(find "org/apache/log" -type d | tr '/' '.') || die "Could not create javadoc"
	fi
}

src_test() {

	mkdir test-classes || die "Unable to make dir"
	local TESTJAR="avalon-logkit-test.jar"
	ejavac -encoding "ISO-8859-1" -classpath "avalon-logkit.jar:$(java-config -p junit-4)" -d test-classes $(find src/test -name '*.java')

	jar -cf "${TESTJAR}" -C test-classes .

	java -cp "avalon-logkit.jar:${TESTJAR}:$(java-config -p junit:4)" \
		org.junit.runner.JUnitCore org.apache.log.format.test.FormatterTestCase \
		org.apache.log.output.test.RevolvingFileStrategyTestCase \
		org.apache.log.output.test.OutputTargetTestCase \
		org.apache.log.output.test.DBTargetTestCase \
		org.apache.log.util.test.UtilTestCase \
		org.apache.log.test.LoggerListenerTestCase \
		org.apache.log.test.WrappingTargetTestCase \
		org.apache.log.test.InheritanceTestCase
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	use doc && java-pkg_dojavadoc "${JAVADOC_DIR}"
	use source && java-pkg_dosrc "${SRC_DIR}/*"
}

