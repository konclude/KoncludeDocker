# This dockerfile executes the build, it starts from the dev environment
FROM koncludedev




# include the source code of Konclude
COPY Konclude/ /usr/local/src/konclude-static
COPY revision-git.h /usr/local/src/konclude-static
COPY UnixGitBuildScript.sh /usr/local/src/konclude-static




# remove intermediate files (to ensure a clean build later)
RUN rm -rf usr/local/src/konclude-static/Release \
&& rm -rf usr/local/src/konclude-static/release \
&& rm -rf usr/local/src/konclude-static/GeneratedFiles



RUN cd /usr/local/src/konclude-static/External/ \
&& mkdir -p jemalloc/Linux/x64/lib/release \
&& cp /usr/local/src/jemalloc-static/lib/libjemalloc.a /usr/local/src/konclude-static/External/jemalloc/Linux/x64/lib/release



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






# These are the build steps
RUN BUILD_DIR=/usr/local/src/konclude-static  \
&& cd $BUILD_DIR \
&& export PATH=/usr/local/lib/qt-static/bin:$PATH \
&& export QTDIR=/usr/local/lib/qt-static \
&& export QTINC=/usr/local/lib/qt-static/include \
&& export QTLIB=/usr/local/lib/qt-static/lib \
&& ls -al /usr/lib/x86_64-linux-gnu/ \
&& sed -i -e 's\unix: LIBS += -lz -lltdl -lgmp -ldl -L External/jemalloc/Linux/x64/lib/release/ -ljemalloc\unix:!macx: LIBS += -lz -ldl /usr/lib/x86_64-linux-gnu/libgmp.a /usr/lib/x86_64-linux-gnu/libltdl.a -L External/jemalloc/Linux/x64/lib/release/ -ljemalloc\g' Konclude.pro \
&& cat Konclude.pro \
&& qmake -r CONFIG+=release CONFIG+=x86_64 CONFIG-=debug CONFIG+=static -spec /usr/local/lib/qt-static/mkspecs/linux-g++-64 Konclude.pro \
&& make \
&& ldd ./Release/Konclude \
&& ./Release/Konclude owllinkfile -c Configs/default-config.xml -v -e -r Tests/Test-response.xml -q Tests/galen-ALEHIF+-classify-request.xml -w 1
