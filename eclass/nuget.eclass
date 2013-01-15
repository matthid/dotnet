# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: nuget.eclass
# @MAINTAINER: Heather@Cynede.net
# @BLURB: Common functionality for nuget apps
# @DESCRIPTION: Common functionality needed by fake build system.

inherit mono

# @FUNCTION: fake_src_configure
# @DESCRIPTION: Runs nothing.
nuget_src_configure() { :; }

# @FUNCTION: fake_src_compile
# @DESCRIPTION: Runs nothing.
nuget_src_compile() { :; }

# @FUNCTION: fake_src_install
# @DESCRIPTION: installs common doc files, if DOCS is
# set, installs those. Gets rid of .la files.
nuget_src_install () {
	nuget install "${PN} -Version ${PV}"
}

EXPORT_FUNCTIONS src_configure src_compile src_install
