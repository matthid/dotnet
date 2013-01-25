# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_DOTNET="net45"

inherit git-2 autotools mono

EGIT_REPO_URI="git://github.com/fsharp/fsharp.git"

DESCRIPTION="The F# Compiler"
HOMEPAGE="https://github.com/fsharp/fsharp"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

MAKEOPTS="-j1"

DEPEND="dev-lang/mono"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

#Compatibily for some weird stuff, Must be removed after some fixes
pkg_postinst() {
	dosym /usr/bin/fsharpc /usr/bin/fsc
	chmod 666 /etc/mono/registry/last-btime
}
