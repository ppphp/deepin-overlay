# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker versionator

DESCRIPTION="Tencent TIM for Linux by Deepin"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="http://packages.deepin.com/deepin/pool/non-free/d"
QQPN="deepin.com.qq.office"
QQ_PV=$(replace_version_separator 3 'deepin' )

SRC_URI="${COMMON_URI}/${QQPN}/${QQPN}_${QQ_PV}_i386.deb"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-emulation/deepin-wine
	app-emulation/deepin-wine-helper"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r opt usr
	fperms 755 /opt/deepinwine/apps/Deepin-TIM/run.sh
}
