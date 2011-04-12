# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

RESTRICT="test"

DESCRIPTION="Lightweight connection pooler for PostgreSQL"
HOMEPAGE="http://pgfoundry.org/projects/pgbouncer/"
SRC_URI="http://pgfoundry.org/frs/download.php/2912/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND="dev-db/postgresql-base
	dev-libs/libevent"
RDEPEND="${DEPEND}"
inherit eutils autotools
pkg_setup() {
	enewgroup pgbouncer
	enewuser pgbouncer -1 -1 -1 pgbouncer
}
inherit eutils autotools
src_prepare() {
	sed -i -e "s,pgbouncer.log,/var/log/pgbouncer/pgbouncer.log," \
		-e "s,pgbouncer.pid,/var/run/pgbouncer/pgbouncer.pid," \
		-e "s,etc/userlist.txt,/etc/userlist.txt," etc/pgbouncer.ini || die
}

src_configure() {
	# --enable-debug is only used to disable stripping
	econf \
		--enable-debug \
		$(use_enable debug cassert) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	insinto /etc
	newins etc/pgbouncer.ini pgbouncer.ini || die "Install failed"
	newinitd "${FILESDIR}"/pgbouncer.initd "${PN}" || die "Install 
failed"

	dodoc README NEWS AUTHORS || die "Install failed"
	if use doc ; then
		dodoc doc/*.txt || die "Install failed"
	fi

	dodir /var/{run,log}/pgbouncer/
	fperms 0700 /var/{run,log}/pgbouncer/
	fowners pgbouncer:pgbouncer /var/{run,log}/pgbouncer/
}

pkg_postinst() {
	einfo "Please read the config.txt for Configuration Directives"
	einfo
	einfo "See 'man pgbouncer' for Administration Commands"
	einfo
	einfo "By default, PgBouncer does not have access to any databases."
	einfo "Create on with permissions needed for your application and"
	einfo "make sure that it exists in pgbouncer's auth_file."
}

