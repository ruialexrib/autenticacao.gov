######################################################################
#
# Automatically generated by qmake (2.01a) Fri Dec 21 12:05:07 2007
######################################################################


include(../_Builds/eidcommon.mak)

TEMPLATE = lib
TARGET = $${JAVALIB}
VERSION = $${JAVALIB_MAJ}.$${JAVALIB_MIN}.$${JAVALIB_REV}

message("Compile $$TARGET")

jar.files = ../jar/$${EIDLIBJAR}
jar.path = $${INSTALL_DIR_LIB}

###
### Installation setup
###
target.path = $${INSTALL_DIR_LIB}
INSTALLS += target jar



CONFIG -= warn_on qt
QMAKE_CXXFLAGS += -fno-strict-aliasing
QMAKE_CFLAGS += -fno-strict-aliasing

###
### special instructions to preprocess the eidlib.h file by swig
### swig will generate the java files and a cpp wrapper file that has to be compiled
### with the other files
### on mac, swig does not work yet, therefore, the file 'eidlibJava_wrapper.cpp' is taken
### as it is retrieved from SVN
###
unix: {
PREPROCESS_FILES=../eidlib/eidlib.i
preprocess.name = execute swig to generate java and c++ wrapper
preprocess.input = PREPROCESS_FILES
preprocess.output = ./GeneratedFiles/eidlibJava_Wrapper.cpp
preprocess.commands = swig -c++ -java -package pt.gov.cartaodecidadao -o ./GeneratedFiles/eidlibJava_Wrapper.cpp -outdir ./GeneratedFiles ../eidlib/eidlib.i
QMAKE_EXTRA_COMPILERS += preprocess
preprocess.variable_out+=SOURCES
}

###
### As a postbuild step, compile the generated .java files and jar them to a jar file
###
unix:QMAKE_POST_LINK = javac -d ../eidlibJava/class ./src/*.java ./GeneratedFiles/*.java && jar cf ../jar/$${EIDLIBJAR} -C ../eidlibJava/class .

## destination directory
DESTDIR = ../lib

DEFINES += EIDMW_CMN_EXPORT

LIBS += -L../lib  \
		-l$${COMMONLIB} \
		-l$${DLGLIB} \
		-l$${CARDLAYERLIB} \
		-l$${APPLAYERLIB}

macx: INCLUDEPATH += /System/Library/Frameworks/JavaVM.framework/Headers/
macx: LIB += -Wl,-framework -Wl,Java

DEPENDPATH += .
INCLUDEPATH += . ../applayer ../dialogs ../common ../cardlayer ../eidlib /usr/lib/jvm/java-8-openjdk-amd64/include /usr/lib/jvm/java-8-openjdk-amd64/include/linux
macx:INCLUDEPATH += /usr/local/include
INCLUDEPATH += $${PCSC_INCLUDE_DIR}

DEFINES += EIDMW_EIDLIB_EXPORTS

# Input

#macx: SOURCES += GeneratedFiles/eidlibJava_Wrapper.cpp
SOURCES += ../eidlib/eidlibCard.cpp
SOURCES += ../eidlib/eidlibCrypto.cpp
SOURCES += ../eidlib/eidlibDoc.cpp
SOURCES += ../eidlib/eidlibException.cpp
SOURCES += ../eidlib/eidlibReader.cpp
SOURCES += ../eidlib/InternalUtil.cpp
SOURCES += ../eidlib/eidlibxades.cpp




