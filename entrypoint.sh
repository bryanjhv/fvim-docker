#!/bin/bash -x

vimver=${1:-8.1.0751}
vimtag=`echo ${vimver:0:3} | tr -d .`
prefix=/opt/vim$vimtag
outdir=/tmp/out/$prefix

cd /tmp
wget https://github.com/vim/vim/archive/v$vimver.tar.gz
tar xfz v$vimver.tar.gz && rm v$vimver.tar.gz

cd vim-$vimver
./configure --prefix=$prefix --enable-fail-if-missing \
            --disable-smack --disable-selinux --disable-netbeans \
            --enable-luainterp=yes --enable-perlinterp=yes \
            --enable-pythoninterp=yes --enable-python3interp=yes \
            --enable-tclinterp=yes --enable-rubyinterp=yes \
            --enable-cscope --enable-terminal --enable-multibyte \
            --disable-arabic --disable-farsi \
            --enable-gui=athena --disable-gtktest \
            --without-local-dir --with-features=huge \
            --with-python-command=python2 --with-python3-command=python3 \
            --with-tclsh=/usr/bin/tclsh --with-x
make

mkdir -p $outdir
make DESTDIR=/tmp/out install

cd /tmp/out
tar cfzv /out/fvim-$vimver.tar.gz .
