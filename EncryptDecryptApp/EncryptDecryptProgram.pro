QT += quick

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        account.cpp \
        controller.cpp \
        crypto.cpp \
        main.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    account.hh \
    controller.hh \
    crypto.hh

macx {
    DEFINES += CRYPTOPP_DISABLE_ASM
}

LIBS += -L/Users/aliisanissinen/Downloads/cryptopp860
INCS += -I/usr/include/crypto++

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../cryptopp860/release/ -lcryptopp
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../cryptopp860/debug/ -lcryptopp
else:unix: LIBS += -L$$PWD/../cryptopp860/ -lcryptopp

INCLUDEPATH += $$PWD/../cryptopp860
DEPENDPATH += $$PWD/../cryptopp860

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../cryptopp860/release/libcryptopp.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../cryptopp860/debug/libcryptopp.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../cryptopp860/release/cryptopp.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../cryptopp860/debug/cryptopp.lib
else:unix: PRE_TARGETDEPS += $$PWD/../cryptopp860/libcryptopp.a
