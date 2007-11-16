# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-pkg-2 lucene-contrib

DESCRIPTION="lucli (pronounced Luckily) is the Lucene Command Line Interface."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-java/jline"
RDEPEND="dev-java/jline"
DOCS="README"
LUCENE_EXTRA_DEPS="jline"
SLOT=2

src_install() {
	lucene-contrib_src_install
	java-pkg_dolauncher ${PN} --main lucli.Lucli
}
