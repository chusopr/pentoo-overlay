# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tools to work with android .dex and java .class files"
HOMEPAGE="https://github.com/pxb1988/dex2jar/releases"
SRC_URI="https://github.com/pxb1988/dex2jar/releases/download/v2.4/dex-tools-v${PV}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/dex-tools-v${PV}"

src_prepare() {
	rm *.bat
	chmod a+x *.sh
	rm *.txt
	cd lib
	rm *.txt

	eapply_user
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${ED}/opt/${PN}" || die "Install failed!"
	for i in *.sh; do
		dosym "${EPREFIX}/opt/${PN}/${i}" "/usr/bin/${i##*/}"
	done
}
