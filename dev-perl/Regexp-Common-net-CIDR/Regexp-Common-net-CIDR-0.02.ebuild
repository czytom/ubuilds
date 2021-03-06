# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-DBI/Apache-DBI-1.06.ebuild,v 1.9 2007/12/04 20:41:32 corsair Exp $

inherit perl-module

DESCRIPTION="Regexp::Common::net::CIDR 	provide patterns for CIDR blocks.  "
#SRC_URI="mirror://cpan/authors/id/P/PG/PGOLLUCCI/${P}.tar.gz"
SRC_URI="mirror://cpan/authors/id/R/RU/RUZ/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ruz/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"


export OPTIMIZE="$CFLAGS"
