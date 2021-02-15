# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="GNOME keyring extension for dde-polkit-agent"
HOMEPAGE="https://github.com/linuxdeepin/dpa-ext-gnomekeyring"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		gnome-base/libgnome-keyring
		dde-base/dde-polkit-agent
		"
DEPEND="${RDEPEND}
		"

src_prepare() {

	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" ${PN}.pro
	QT_SELECT=qt5 eqmake5	PREFIX=/usr
	default_src_prepare
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
