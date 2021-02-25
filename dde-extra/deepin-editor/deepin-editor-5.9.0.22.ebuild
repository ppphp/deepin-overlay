# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Simple editor for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-editor"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtx11extras:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		kde-frameworks/syntax-highlighting
		kde-frameworks/kcodecs
		sys-auth/polkit-qt[qt5(+)]
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXtst
		x11-libs/xcb-util
		x11-libs/libxcb
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		dev-cpp/gtest
		dev-qt/linguist-tools
		dev-qt/qtchooser
		virtual/pkgconfig
		"

src_prepare() {
	sed -i "s|-DCMAKE|-DCMAKE_INSTALL_LIBDIR=\$path/../lib/lib -DCMAKE|" third/uchartdet_install.sh || die

	sed -i "/<QPainter>/a\#include\ <QPainterPath>" \
		src/widgets/bottombar.cpp \
		src/thememodule/themeitemdelegate.cpp \
		src/thememodule/themepanel.cpp || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}
