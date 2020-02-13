# This dockerfile executes the build, it starts from the dev environment
FROM koncludedev

# These are the build steps
RUN BUILD_DIR=/usr/local/src/konclude-static  \
&& cd $BUILD_DIR \
&& export PATH=/usr/local/lib/qt-static/bin:$PATH \
&& export QTDIR=/usr/local/lib/qt-static \
&& export QTINC=/usr/local/lib/qt-static/include \
&& export QTLIB=/usr/local/lib/qt-static/lib \
&& sed -i -e 's\unix:!macx: LIBS += -lz -lltdl -lgmp -ldl\unix:!macx: LIBS += -lz -lgmp -ldl /usr/lib/x86_64-linux-gnu/libltdl.a\g' Konclude.pro \
&& qmake -r CONFIG+=release CONFIG+=x86_64 CONFIG-=debug CONFIG+=static -spec /usr/local/lib/qt-static/mkspecs/linux-g++-64 Konclude.pro \
&& make -j 10 \
&& ./Release/Konclude owllinkfile -c Configs/default-config.xml -v -e -r Tests/Test-response.xml -q Tests/galen-ALEHIF+-classify-request.xml -w 1
