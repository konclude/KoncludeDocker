# This dockerfile makes a snapshot of the development environment
FROM koncluderun

# install build dependencies
RUN apt-get install -y \
apt-utils \
git \
build-essential \
make \
wget \
xz-utils \
python \
flex \
gperf \
python-dev \
autotools-dev \
automake \
autoconf \
libtool \
gtk-doc-tools \
libgmp3-dev \
zlib1g-dev 



RUN cd /usr/local/src/ \
&& wget http://ftp.gnu.org/gnu/bison/bison-3.7.6.tar.gz \
&& tar -zxvf bison-3.7.6.tar.gz \
&& cd bison-3.7.6 \
&& ./configure \
&& make \
&& sudo make install


# download, build and install qt
RUN cd /usr/local/src/ \
&& wget -q https://download.qt.io/official_releases/qt/5.12/5.12.10/single/qt-everywhere-src-5.12.10.tar.xz \
&& tar -xJf qt-everywhere-src-5.12.10.tar.xz \
&& mv qt-everywhere-src-5.12.10 qt-static \
&& cd /usr/local/src/qt-static \
&& export MAKE=/usr/bin/make \
&& ./configure -static -prefix /usr/local/lib/qt-static -extprefix /usr/local/lib/qt-static -no-opengl -nomake examples -nomake tests -nomake tools -skip webview -skip webchannel -skip 3d -skip script -skip webengine -opensource -platform linux-g++-64 -no-icu -confirm-license -opensource \
&& make \
&& make install \
&& make clean



# download, build and install libxml2
RUN cd /usr/local/src/ \
&& wget ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz \
&& tar -xvzf libxml2-2.9.9.tar.gz \
&& mv libxml2-2.9.9 libxml2-static \
&& cd libxml2-static \
&& ./configure --prefix=/usr/local/lib/libxml2-static \
&& make \
&& make install





# download, build and install raptor
RUN cd /usr/local/src/ \
&& wget http://download.librdf.org/source/raptor2-2.0.15.tar.gz \
&& tar -xvzf raptor2-2.0.15.tar.gz \
&& mv raptor2-2.0.15 raptor2-static \
&& cd raptor2-static \
&& export LIBS="-L/usr/local/lib/libxml2-static/lib -lxml2" \
&& export LIBXML_LIBS="-L/usr/local/lib/libxml2-static/lib -lxml2" \
&& export LIBXML_LIBS="/usr/local/lib/libxml2-static/libxml2.a" \
&& ./configure --prefix=/usr/local/lib/raptor2-static --with-xml2-config=/usr/local/lib/libxml2-static/bin/xml2-config \
&& make \
&& make install



# download, build and install rasqal
RUN cd /usr/local/src/ \
&& git clone git://github.com/konclude/rasqal.git \
&& mv rasqal rasqal-static \
&& cd rasqal-static \
\
&& export RAPTOR2_CFLAGS="-I /usr/local/lib/raptor2-static/include/raptor2" \
&& export RAPTOR2_LIBS="-L/usr/local/lib/raptor2-static/lib -lraptor2 -L/usr/local/lib/libxml2-static/lib -lxml2 -lm -ldl" \
&& export RAPTOR_VERSION=2.0.15 \
&& sed -i -e 's#RAPTOR_VERSION=`$PKG_CONFIG raptor2 --modversion 2>/dev/null`#if test -n "$RAPTOR_VERSION"; then echo "Assuming raptor version $RAPTOR_VERSION"; else RAPTOR_VERSION=`$PKG_CONFIG raptor2 --modversion 2>/dev/null`; fi#g' configure.ac \
&& git log --oneline | grep -q 0c42ebc \
\
&& ./autogen.sh --prefix=/usr/local/lib/rasqal-static \
&& (make \
|| (sed -i -e 's#yycleanup(yyscanner);# #g' src/sparql_lexer.c \
&& sed -i -e 's#extern int yylex#extern int sparql_lexer_lex#g' src/sparql_lexer.h \
&& sed -i -e 's#define YY_DECL int yylex#define YY_DECL int sparql_lexer_lex#g' src/sparql_lexer.h \
&& make -j)) \
&& make install






# download, build and install redland rdflib
RUN cd /usr/local/src/ \
&& wget http://download.librdf.org/source/redland-1.0.17.tar.gz \
&& tar -xvzf redland-1.0.17.tar.gz \
&& mv redland-1.0.17 redland-static \
&& cd redland-static \
\
&& export RAPTOR2_CFLAGS="-I /usr/local/lib/raptor2-static/include/raptor2" \
&& export RAPTOR2_LIBS="-L/usr/local/lib/raptor2-static/lib -lraptor2 -L/usr/local/lib/libxml2-static/lib -lxml2 -lm -ldl" \
&& export RAPTOR_VERSION=2.0.15 \
&& sed -i -e 's#RAPTOR_VERSION=`$PKG_CONFIG raptor2 --modversion 2>/dev/null`#if test -n "$RAPTOR_VERSION"; then echo "Assuming raptor version $RAPTOR_VERSION"; else RAPTOR_VERSION=`$PKG_CONFIG raptor2 --modversion 2>/dev/null`; fi#g' configure \
\
&& export RASQAL_CFLAGS="-I /usr/local/lib/rasqal-static/include/rasqal" \
&& export RASQAL_LIBS="-L/usr/local/lib/rasqal-static/lib -lrasqal -L/usr/local/lib/raptor-static/lib -lraptor2 -L/usr/local/lib/libxml2-static/lib -lxml2 -lm -ldl -lm" \
&& export RASQAL_VERSION=0.9.33 \
&& sed -i -e 's#RASQAL_VERSION=`$PKG_CONFIG rasqal --modversion 2>/dev/null`#if test -n "$RASQAL_VERSION"; then echo "Assuming rasqal version $RASQAL_VERSION"; else RASQAL_VERSION=`$PKG_CONFIG rasqal --modversion 2>/dev/null`; fi#g' configure \
\
&& ./configure --prefix=/usr/local/lib/redland-static \
&& make \
&& make install






RUN cd /usr/local/src/ \
&& wget https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 \
&& tar -xf jemalloc-5.2.1.tar.bz2 --no-same-owner \
&& mv jemalloc-5.2.1 jemalloc-static \
&& cd jemalloc-static \
&& ./configure --prefix=/usr/local/lib/jemalloc-static \
&& make \
&& make install


