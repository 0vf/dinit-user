#!/bin/sh
scriptdir=$(dirname "$0")

spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

start-build() {
	cd $scriptdir || exit 1
	mkdir -p work || exit 1
	cd work || exit 1
	printf "%s\n" "git clone"
	git clone https://github.com/davmac314/dinit.git || exit 1
	cd dinit || exit 1
	printf "%s\n" "Cloning done. Initializing meson..."
	printf "%s\n" "meson setup"
	meson setup -Ddinit-sbindir="$HOME/.local/sbin" -Dprefix="$HOME/.local" . _build || exit 1
	cd _build
	printf "%s\nninja"
	ninja
}

install(){
	[ -d "$scriptdir/work/dinit/_build" ] || $(printf "%s\n" "Please run dinit-user.sh build" && exit 1)
	cd $scriptdir/work/dinit/_build
	ninja install
	cd ../../..
	cp -r files $HOME/.config/dinit.d
}

uninstall(){
	[ -f "$HOME/.local/sbin/dinit" ] || $(printf "%s\n" "Please run dinit-user.sh install" && exit 1)
	cd $scriptdir/work/dinit/_build
	ninja uninstall
}

case $1 in
	build) start-build;;
	install) install;;
	uninstall) uninstall;;
	*) printf "%s\n" "./dinit-user.sh build|install|uninstall|why are you running this directly|use the makefile|use make";;
esac