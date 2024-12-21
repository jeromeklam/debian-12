cd /tmp
wget https://www.openssl.org/source/openssl-1.1.1q.tar.gz
tar xf openssl-1.1.1q.tar.gz
cd openssl-1.1.1q
./config --prefix=/opt/openssl-1.1.1q --openssldir=/opt/openssl-1.1.1q shared zlib
make
make test
make install