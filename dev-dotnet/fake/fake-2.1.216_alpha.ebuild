# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_DOTNET="net40"

inherit nuget dotnet git-2

DESCRIPTION="FAKE - F# Make"
HOMEPAGE="http://nuget.org/packages/FAKE"

SRC_URI=""

EGIT_REPO_URI="git://github.com/fsharp/FAKE.git"
EGIT_TAG="${NPV}"

LICENSE="MS-PL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+nuget"

DEPEND="dev-lang/mono
dev-lang/fsharp"
RDEPEND="${DEPEND}"

src_unpack() {
	if use nuget ; then
		echo "using nuget"
		nuget_src_unpack
	else
		ewarn "!!! Trying git tag, it's not safe !!!"
		git-2_src_unpack
	fi
}

src_prepare() {
	if use nuget ; then
		echo "installation is done via nuget"
	else
		./build.sh
	fi
}

src_install() {
	elog "Installing libraries"
	insinto /usr/lib/mono/FAKE/"${FRAMEWORK}"/
	if use nuget ; then
		doins FAKE."${NPV}"/tools/FAKE.exe || die
		doins FAKE."${NPV}"/tools/FakeLib.dll || die
		doins FAKE."${NPV}"/tools/Newtonsoft.Json.dll
		doins FAKE."${NPV}"/tools/Fake.SQL.dll
	else
		doins build/FAKE.exe || die
		doins build/FakeLib.dll || die
	fi
}

pkg_postinst() {
	#Weird Solution to find NuGet.Core.dll :
	ln -s "/usr/lib/mono/NuGet/4.5/NuGet.Core.dll" "/usr/lib/mono/FAKE/${FRAMEWORK}/NuGet.Core.dll"
	#Exec :
	echo "mono /usr/lib/mono/FAKE/${FRAMEWORK}/FAKE.exe \"\$@\"" > /usr/bin/fake
	chmod 777 /usr/bin/fake
}
