# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="readline source doc servletapi mysql postgres examples oracle"
#jdnc 

EAPI=1

inherit base java-pkg-2 java-ant-2

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="http://www.jython.org"

MY_PV="installer-2.2.1"
PYVER="2.2.3"
HT2HTML="ht2html-2.0"

SRC_URI="http://www.python.org/ftp/python/${PYVER%_*}/Python-${PYVER}.tgz
mirror://sourceforge/${PN}/${PN}_${MY_PV}.jar
mirror://sourceforge/ht2html/${HT2HTML}.tar.gz"

LICENSE="JPython"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="=dev-java/jakarta-oro-2.0*
	readline? ( >=dev-java/libreadline-java-0.8.0 )
	mysql? ( >=dev-java/jdbc-mysql-3.1 )
	postgres? ( dev-java/jdbc-postgresql )
	oracle? ( dev-java/jdbc-oracle-bin:10.2 )"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
		dev-java/javacc
		servlet? ( java-virtuals/servlet-api:2.5 )
		${CDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/test.patch"
	#mv build.xml build.xml.orig
	#sed 's/if="full-build"//' \
	#build.xml.orig > build.xml

	echo javacc.jar="$(java-pkg_getjars --build-only javacc)" > ant.properties

	if use readline; then
		echo "readline.jar=$(java-pkg_getjars libreadline-java)" >> \
		ant.properties
	fi
	if use servlet; then
		echo "servlet.jar=$(java-pkg_getjar --build-only servlet-api-2.5 servlet.jar)" \
		>> ant.properties
	fi
	if use mysql; then
		echo "mysql.jar=$(java-pkg_getjar jdbc-mysql jdbc-mysql.jar)" \
		>> ant.properties
	fi

	if use postgres; then
		echo \
		"postgresql.jar=$(java-pkg_getjar jdbc-postgresql jdbc-postgresql.jar)"\
		 >> ant.properties
	fi

	if use oracle; then
		echo \
		"oracle.jar=$(java-pkg-getjar jdbc-oracle-bin-10.2 ojdbc14.jar)" \
		>> ant.properties
	fi
}


src_compile() {
	local antflags="-Dbase.path=src/java -Dsource.dir=src/java/src"
	antflags="${antflags} -Dht2html.dir=${HT2HTML}"
	local pylib="Python-${PYVER}/Lib"
	antflags="${antflags} -Dpython.lib=${pylib} -Dsvn.checkout.dir=."
	LC_ALL=C eant ${antflags} developer-build $(use_doc javadoc)
}

src_test() {
	local antflags="-Dbase.path=src/java -Dsource.dir=src/java/src"
	antflags="${antflags} -Dpython.home=dist"
	local pylib="Python-${PYVER}/Lib"
	antflags="${antflags} -Dpython.lib=${pylib}"
	eant ${antflags} regrtest
}


src_install() {
	java-pkg_dojar "dist/${PN}.jar"

	dodoc README.txt NEWS ACKNOWLEDGMENTS
	use doc && dohtml -A .css .jpg .gif -r Doc/*

	local java_args="-Dpython.home=/usr/share/jython"
	java_args="${java_args} -Dpython.cachedir=\${HOME}/.jythoncachedir"

	java-pkg_dolauncher jythonc \
						--main "org.python.util.jython" \
						--java_args "${java_args}" \
						--pkg_args "${java_args} /usr/share/jython/tools/jythonc/jythonc.py"

	java-pkg_dolauncher jython \
						--main "org.python.util.jython" \
						--pkg_args "${java_args}"

	#Need to finallise cacheing and the like.
	#dodir /var/cache/jython
	#chmod a+rw ${D}/var/cache/jython

	#rm Demo/jreload/example.jar
	insinto /usr/share/${PN}
	doins -r dist/Lib registry

	insinto /usr/share/${PN}/tools
	doins -r dist/Tools/*

	use doc && java-pkg_dojavadoc dist/Doc/javadoc
	use source && java-pkg_dosrc src
	use examples && java-pkg_doexamples dist/Demo/*
}

pkg_postinst() {
	if use readline; then
		elog "To use readline you need to add the following to your registry"
		elog
		elog "python.console=org.python.util.ReadlineConsole"
		elog "python.console.readlinelib=GnuReadline"
		elog
		elog "The global registry can be found in /usr/share/${PN}/registry"
		elog "User registry in \$HOME/.jython"
		elog "See http://www.jython.org/docs/registry.html for more information"
		elog ""
	fi
}