# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Install and Uninstall Font File for Users"
HOMEPAGE="https://github.com/linuxdeepin/deepin-font-manager"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtcore:5
		 dev-qt/qtgui:5
		 dev-qt/qtwidgets:5
		 media-libs/freetype:2
		 media-libs/fontconfig
		 dde-base/dde-file-manager:=
		 !dde-extra/deepin-font-installer
	     "
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
	    "

src_prepare() {
	sed -i "/<QPainter>/a\#include\ <QPainterPath>" \
		deepin-font-manager/interfaces/dfontpreviewitemdelegate.cpp \
		deepin-font-manager/interfaces/dfontpreviewer.cpp \
		deepin-font-manager/views/dsplitlistwidget.cpp \
		deepin-font-manager/views/dfontspinner.cpp \
		deepin-font-manager/views/dfinstallerrorlistview.cpp || die
	sed -i "/<DMenu>/a\#include\ <QContextMenuEvent>\n\#include\ <QDragEnterEvent>\n\#include\ <QDropEvent>\n\#include\ <QFocusEvent>\n\#include <QKeyEvent>\n\#include\ <QMouseEvent>" \
		deepin-font-manager/views/dfontmgrmainwindow.cpp || die
	sed -i "/<QMenu>/a\#include\ <QFocusEvent>\n\#include <QKeyEvent>\n\#include\ <QMouseEvent>" \
		deepin-font-manager/interfaces/dfontpreviewlistview.cpp || die
	sed -i "/<QHBoxLayout>/a\#include <QKeyEvent>" \
		deepin-font-manager/views/dfdeletedialog.cpp || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}
