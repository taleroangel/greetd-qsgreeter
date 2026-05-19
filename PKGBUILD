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
	make DESTDIR="$pkgdir" install
}
