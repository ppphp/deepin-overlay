# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="GNOME keyring extension for dde-polkit-agent"
HOMEPAGE="https://github.com/linuxdeepin/dpa-ext-gnomekeyring"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/master.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		app-crypt/libsecret
		dde-base/dde-polkit-agent
		"
DEPEND="${RDEPEND}
		"

src_unpack () {
	tar -xvf $DISTDIR/${P}.tar.gz -C $WORKDIR
	mv $WORKDIR/dpa-ext-gnomekeyring-{master,5.0.5}
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

