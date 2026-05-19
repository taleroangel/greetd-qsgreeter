# Maintainer: Angel Talero <angelgotalero@outlook.com>
pkgname=qsgreeter-git
pkgver=r10.5ad98e8
pkgrel=1
pkgdesc='QuickShell greeter for greetd'
arch=('any')
url='https://github.com/taleroangel/greetd-qsgreeter'
license=('MIT')
depends=('greetd' 'quickshell')
optdepends=('niri: recommended wayland compositor')
makedepends=('git')
source=("${pkgname}::git+${url}.git")
sha256sums=('SKIP')

pkgver() {
	cd "$pkgname"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
}

package() {
	cd "$pkgname"
	_quickshell_dir="etc/xdg/quickshell/qsgreeter"
	_greetd_dir="etc/greetd"

	# Install qsgreeter files into quickshell directory
	install -dm0755 "${pkgdir}/${_quickshell_dir}"
	find qsgreeter -type f -exec install -Dm0644 "{}" "${pkgdir}/${_quickshell_dir}/{}" \;
	find "${pkgdir}/${_quickshell_dir}" -type d -exec chmod 0755 {} +

	# Install niri configuration file (if niri is present)
	if pacman -Qi "niri" &>/dev/null; then
		echo ":: Installed 'qsgreeter-niri.kdl' configuration file into '/${_greetd_dir}'"
		install -Dm0644 "niri/qsgreeter-niri.kdl" "${pkdir}/${_greetd_dir}/qsgreeter-niri.kdl"
	fi

	# Installation finished
	echo ":: Run qsgreeter with 'quickshell -c qsgreeter'"
}
