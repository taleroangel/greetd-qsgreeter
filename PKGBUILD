# Maintainer: Angel Talero <angelgotalero@outlook.com>
_pkgname=qsgreeter
pkgname=$_pkgname-git
pkgver=r10.5ad98e8
pkgrel=1
pkgdesc='QuickShell greeter for greetd'
arch=('any')
url='https://github.com/taleroangel/greetd-qsgreeter'
license=('MIT')
depends=('greetd' 'quickshell')
optdepends=('niri: recommended wayland compositor')
makedepends=('git')
source=("${_pkgname}::git+${url}.git")
sha256sums=('SKIP')

pkgver() {
	cd "$_pkgname"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
}

package() {
	cd "$_pkgname"
	_quickshell_dir="etc/xdg/quickshell/qsgreeter"
	_greetd_dir="etc/greetd"

	# Install qsgreeter files into quickshell directory
	install -dm755 "${pkgdir}/${_quickshell_dir}"
	find qsgreeter -type f -exec install -Dm644 "{}" "${pkgdir}/${_quickshell_dir}/{}" \;
	find "${pkgdir}/${_quickshell_dir}" -type d -exec chmod 755 {} +

	# Install niri configuration file (if niri is present)
	if pacman -Qi "niri" &>/dev/null; then
		echo ":: Installed 'qsgreeter-niri.kdl' configuration file into '/${_greetd_dir}'"
		install -Dm644 "niri/qsgreeter-niri.kdl" "${pkdir}/${_greetd_dir}/qsgreeter-niri.kdl"
	fi

	# Install licenses
	install -Dm644 LICENSE -t "${pkgdir}/usr/share/licenses/${_pkgname}/LICENSE"

	# Installation finished
	echo ":: Run qsgreeter with 'quickshell -c qsgreeter'"
}
