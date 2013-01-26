# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_DOTNET="net40"

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

pkg_postinst() {
	#trick FAKE comparibility
	mkdir /usr/local/lib/
	mkdir /usr/local/lib/mono
	mkdir /usr/local/lib/mono/2.0
	mkdir /usr/local/lib/mono/4.0
	ln -s /usr/lib/mono/Microsoft\ F\#/v4.0/FSharp.Core.dll /usr/local/lib/mono/4.0/FSharp.Core.dll
	ln -s /usr/lib/mono/Microsoft\ F\#/v2.0/FSharp.Core.dll /usr/local/lib/mono/2.0/FSharp.Core.dll
	dosym /usr/bin/fsharpc /usr/bin/fsc
	chmod 666 /etc/mono/registry/last-btime
}
