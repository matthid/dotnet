# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils mono-env git-2 autotools-utils

DESCRIPTION="A flexible, irssi-like and user-friendly IRC client for the Gnome Desktop"
HOMEPAGE="http://www.smuxi.org/main/"

SLOT="0"
KEYWORDS=""
IUSE="dbus debug gtk libnotify spell +heather"
LICENSE="|| ( GPL-2 GPL-3 )"

RDEPEND="
	>=dev-lang/mono-3.0
	>=dev-dotnet/smartirc4net-0.4.5.1
	>=dev-dotnet/nini-1.1.0-r2
	=dev-dotnet/log4net-1.2.10
	dbus? (	dev-dotnet/ndesk-dbus
		dev-dotnet/ndesk-dbus-glib )
	gtk? ( >=dev-dotnet/gtk-sharp-2.12 )
	libnotify? ( dev-dotnet/notify-sharp )
	spell? ( >=app-text/gtkspell-2.0.9:2 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

if use heather; then
	EGIT_REPO_URI="git://github.com/Heather/smuxi.git"
	EGIT_MASTER="heather"
else
	EGIT_REPO_URI="git://github.com/meebey/smuxi.git"
	EGIT_MASTER="master"
fi

DOCS=( FEATURES TODO README )

src_prepare() {
	autotools-utils_autoreconf
	autotools-utils_src_prepare
}

src_configure() {
        local myeconfargs=(
		--enable-engine-irc
		--without-indicate
		--with-vendor-package-version="Gentoo ${PV}"
		--with-db4o=included
		--with-messaging-menu=no
		--with-indicate=no
		--disable-engine-jabbr
		$(use_enable debug)
		$(use_enable gtk frontend-gnome)
		$(use_with libnotify notify)
		$(use_with spell gtkspell)
	)
	autotools-utils_src_configure
}

src_install() {
	default
	#runner scripts fix
	sed -i -e 's@mono --debug@mono --runtime=v4.0@g' "${ED}"/usr/bin/smuxi-frontend-gnome || die
	sed -i -e 's@mono --debug@mono --runtime=v4.0@g' "${ED}"/usr/bin/smuxi-server || die
}
