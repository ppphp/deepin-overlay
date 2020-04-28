# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils xdg-utils
DESCRIPTION="Deepin Movie Player"
HOMEPAGE="https://github.com/linuxdeepin/deepin-movie-reborn"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
	EGIT_BRANCH="vpu"
else
    SRC_URI="https://community-packages.deepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}.orig.tar.xz -> ${P}.tar.xz"
fi

LICENSE="GPL-3+"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdbus:5
		dev-qt/qtwidgets:5
		dev-qt/linguist-tools:5
		dev-qt/qtsvg:5
		dev-qt/qtmultimedia:5
		dev-qt/qtx11extras:5
		dev-libs/openssl
		media-video/mpv[libmpv,dvd]
		x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-wm
		x11-base/xcb-proto
		x11-base/xorg-proto
		media-video/ffmpegthumbnailer
		x11-libs/libXtst
		media-sound/pulseaudio
		media-video/ffmpeg
		media-libs/libdvdnav
		"
RDEPEND="${DEPEND}
		>=dde-base/dtkcore-5.1.2
		>=dde-base/dtkwidget-5.1.2:=
		"

src_prepare() {
    LIBDIR=$(get_libdir)
    sed -i "s|lib/|${LIBDIR}/|g" src/CMakeLists.txt || die
    cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
    xdg_icon_cache_update
}