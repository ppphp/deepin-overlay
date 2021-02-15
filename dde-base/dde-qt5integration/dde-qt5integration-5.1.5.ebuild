# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit qmake-utils

DESCRIPTION="DDE system integration plugin for Qt5"
HOMEPAGE="https://github.com/linuxdeepin/qt5integration"
MY_PN=${PN#*-}
MY_P=${MY_PN}-${PV}

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${MY_PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/libqtxdg
	dev-qt/qtcore:5=
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	dev-qt/qtx11extras:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsvg:5
	media-libs/fontconfig
	media-libs/freetype
	dev-qt/dde-qt5platform-plugins
	"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	>=dde-base/dtkwidget-5.1.2:=
	"

PATCHES=( 	
	"${FILESDIR}"/${PN}-5.1.0.1-qt5.15.patch 
)

src_prepare() {
	default
	sed -i "/<DTabBar>/a\#include\ <DSpinBox>" styleplugins/chameleon/chameleonstyle.cpp || die 
	QT_SELECT=qt5 eqmake5 ${MY_PN}.pro
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
