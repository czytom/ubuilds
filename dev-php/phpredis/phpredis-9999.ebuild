# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"
PHPSAPILIST="apache2 cgi cli fpm"

inherit php-ext-source-r2 git-2 autotools

DESCRIPTION="A PHP extension for Redis."
HOMEPAGE="https://github.com/nicolasff/phpredis"
EGIT_REPO_URI="git://github.com/nicolasff/phpredis.git"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="threads"

DEPEND="dev-lang/php[threads=]"
RDEPEND="${DEPEND}"

