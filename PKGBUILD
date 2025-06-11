# Maintainer: denisde4ev <aski7ubh0@mozmail.com>

# supported values: "systemd" and "operc" 
#_init_system=systemd
_init_system=openrc


#_pkgname=duckdns
pkgname=duckdns-${_init_system}
pkgver=1.1
pkgrel=1
pkgdesc="Update your DuckDNS.org entries from your computer."
arch=('any')
url="https://github.com/mdomlop/duckdns"
backup=("etc/duckdns.d/default.conf")
makedepends=('python-docutils')
depends=(curl)
conflicts=(duckdns)
provides=(duckdns)
# group=(duckdns)
install="services/$_init_system/duckdns.install"

source=('default.conf' 'duckdns.sh' 'README.rst')

### DOES NOT WORK!... makepkg, cant have source in nested dir...!
## case $_init_system in
## 	systemd)
## 		source=("${source[@]}" "./services/$_init_system/duckdns.service")
## 		source=("${source[@]}" "./services/$_init_system/duckdns.timer")
## 	;;
## 	openrc)
## 		source=("${source[@]}" "./services/$_init_system/duckdns.$_init_system.sh")
## 	;;
## esac
### I'll just use ${startdir} directly

md5sums=(); for i in "${source[@]}"; do md5sums=("${md5sums[@]}" SKIP); done



build() {
	rst2man README.rst | gzip -c > "${srcdir}/duckdns.1.gz"
}

package() {
	install -Dm755 "${srcdir}/duckdns.sh" "${pkgdir}/usr/bin/duckdns"
	install -dm755 "${pkgdir}/etc/duckdns.d"
	install -Dm644 "${srcdir}/default.conf" "${pkgdir}/etc/duckdns.d/default.conf"

	# manpage
	install -Dm644 "${srcdir}/duckdns.1.gz" "${pkgdir}/usr/share/man/man1/duckdns.1.gz"

	case $_init_system in
		systemd)
			# systemd services
			install -Dm644 "${startdir}/services/$_init_system/duckdns.service" "${pkgdir}/usr/lib/systemd/system/duckdns.service"
			install -Dm644 "${startdir}/services/$_init_system/duckdns.timer"   "${pkgdir}/usr/lib/systemd/system/duckdns.timer"
		;;
		openrc)
			install -Dm755 "${startdir}/services/$_init_system/duckdns.init"    "${pkgdir}/etc/init.d/duckdns"
			install -Dm755 "${startdir}/services/$_init_system/duckdns.conf"    "${pkgdir}/etc/init.d/duckdns.conf"
		;;
	esac
}



