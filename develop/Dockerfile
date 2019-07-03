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
bison \
gperf \
python-dev






# download, build and install qt
RUN cd /usr/local/src/ \
&& wget https://download.qt.io/official_releases/qt/5.13/5.13.0/single/qt-everywhere-src-5.13.0.tar.xz \
&& tar -xJf qt-everywhere-src-5.13.0.tar.xz \
&& mv qt-everywhere-src-5.13.0 qt-static \
&& cd /usr/local/src/qt-static \
&& export MAKE=/usr/bin/make \
&& ./configure -static -prefix /usr/local/lib/qt-static -extprefix /usr/local/lib/qt-static -no-opengl -nomake examples -nomake tests -opensource -platform linux-g++-64 -no-icu -confirm-license -opensource \
&& make -j \
&& make install



# download, build and install libxml2
RUN cd /usr/local/src/ \
&& wget ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz \
&& tar -xvzf libxml2-2.9.9.tar.gz \
&& mv libxml2-2.9.9 libxml2-static \
&& cd libxml2-static \
&& ./configure --prefix=/usr/local/lib/libxml2-static \
&& make -j \
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
&& make -j \
&& make install



# download, build and install rasqual
RUN cd /usr/local/src/ \
&& wget http://download.librdf.org/source/rasqal-0.9.33.tar.gz \
&& tar -xvzf rasqal-0.9.33.tar.gz \
&& mv rasqal-0.9.33 rasqal-static \
&& cd rasqal-static \
\
&& export RAPTOR2_CFLAGS="-I /usr/local/lib/raptor2-static/include/raptor2" \
&& export RAPTOR2_LIBS="-L/usr/local/lib/raptor2-static/lib -lraptor2 -L/usr/local/lib/libxml2-static/lib -lxml2 -lm -ldl" \
&& export RAPTOR_VERSION=2.0.15 \
&& sed -i -e 's#RAPTOR_VERSION=`$PKG_CONFIG raptor2 --modversion 2>/dev/null`#if test -n "$RAPTOR_VERSION"; then echo "Assuming raptor version $RAPTOR_VERSION"; else RAPTOR_VERSION=`$PKG_CONFIG raptor2 --modversion 2>/dev/null`; fi#g' configure \
\
&& ./configure --prefix=/usr/local/lib/rasqal-static \
&& make -j \
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
&& make -j \
&& make install




# include the source code of Konclude
COPY Konclude/ /usr/local/src/konclude-static
COPY revision-git.h /usr/local/src/konclude-static
COPY UnixGitBuildScript.sh /usr/local/src/konclude-static


# remove intermediate files (to ensure a clean build later)
RUN rm -rf usr/local/src/konclude-static/Release \
&& rm -rf usr/local/src/konclude-static/release \
&& rm -rf usr/local/src/konclude-static/GeneratedFiles




RUN cp /usr/local/lib/libxml2-static/lib/libxml2.so.2.9.9 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/libxml2-static/lib/libxml2.so.2 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/libxml2-static/lib/libxml2.so /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/libxml2-static/lib/libxml2.la /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/libxml2-static/lib/libxml2.a /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
\
&& cp /usr/local/lib/raptor2-static/lib/libraptor2.so.0.0.0 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/raptor2-static/lib/libraptor2.so.0 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/raptor2-static/lib/libraptor2.so /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/raptor2-static/lib/libraptor2.la /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/raptor2-static/lib/libraptor2.a /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
\
&& cp /usr/local/lib/rasqal-static/lib/librasqal.so.3.0.0 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/rasqal-static/lib/librasqal.so.3 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/rasqal-static/lib/librasqal.so /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/rasqal-static/lib/librasqal.la /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/rasqal-static/lib/librasqal.a /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
\
&& cp /usr/local/lib/redland-static/lib/librdf.so.0.0.0 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/redland-static/lib/librdf.so.0 /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/redland-static/lib/librdf.so /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/redland-static/lib/librdf.la /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release \
&& cp /usr/local/lib/redland-static/lib/librdf.a /usr/local/src/konclude-static/External/librdf/Linux/x64/lib/release





