yum install  -y -q cmake3 bison flex yacc openssl-devel zlib-devel libevent boost-* ghc glib-devel python-devel java-1.7.0-openjdk-devel ant

cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local -DBUILD_COMPILER=ON -DBUILD_LIBRARIES=ON 