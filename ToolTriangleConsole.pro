#include(../RibiClasses/CppAbout/CppAbout.pri)
#include(../RibiClasses/CppFileIo/CppFileIo.pri)
#include(../RibiClasses/CppHelp/CppHelp.pri)
#include(../RibiClasses/CppMenuDialog/CppMenuDialog.pri)
#include(../RibiClasses/CppTestTimer/CppTestTimer.pri)
#include(../RibiClasses/CppTrace/CppTrace.pri)

include(ToolTriangleConsole.pri)

SOURCES += main.cpp

# C++14
CONFIG += c++14
QMAKE_CXXFLAGS += -std=c++14

# High warning levels
# Qt does not go well with -Weffc++
# apfloat does not go well with -Wshadow
QMAKE_CXXFLAGS += -Wall -Wextra -Wnon-virtual-dtor -pedantic -Werror

# Debug and release mode
CONFIG += debug_and_release

# In release mode, define NDEBUG
CONFIG(release, debug|release) {

  DEFINES += NDEBUG

  # gprof
  QMAKE_CXXFLAGS += -pg
  QMAKE_LFLAGS += -pg

  # GSL
  DEFINES += GSL_UNENFORCED_ON_CONTRACT_VIOLATION
}

# In debug mode, turn on gcov and UBSAN
CONFIG(debug, debug|release) {

  # gcov
  QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
  LIBS += -lgcov

  # UBSAN
  QMAKE_CXXFLAGS += -fsanitize=undefined
  QMAKE_LFLAGS += -fsanitize=undefined
  LIBS += -lubsan

  # gprof
  QMAKE_CXXFLAGS += -pg
  QMAKE_LFLAGS += -pg

  # GSL
  #DEFINES += GSL_THROW_ON_CONTRACT_VIOLATION
  DEFINES += GSL_UNENFORCED_ON_CONTRACT_VIOLATION
}

# Qt
QT += core gui

# Prevent Qt for failing with this error:
# qrc_[*].cpp:400:44: error: ‘qInitResources_[*]__init_variable__’ defined but not used
# [*]: the resource filename
QMAKE_CXXFLAGS += -Wno-unused-variable

# Fixes
#/usr/include/boost/math/constants/constants.hpp:277: error: unable to find numeric literal operator 'operator""Q'
#   BOOST_DEFINE_MATH_CONSTANT(half, 5.000000000000000000000000000000000000e-01, "5.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e-01")
#   ^
QMAKE_CXXFLAGS += -fext-numeric-literals

message(Host name: $$QMAKE_HOST.name)
contains(QMAKE_HOST.name,pc-157-103) {
  message("Host is university computer in the canteen")
  QMAKE_CXX = g++-5
  QMAKE_LINK = g++-5
  QMAKE_CC = gcc-5
}

message(Host name: $$QMAKE_HOST.name)
contains(QMAKE_HOST.name,fwn-biol-132-102) {
  message("Host is university computer in my office")
  QMAKE_CXX = g++-5
  QMAKE_LINK = g++-5
  QMAKE_CC = gcc-5
}
