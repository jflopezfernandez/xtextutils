
vpath %.cpp src
vpath %.h include

AS := as
CC := gcc
CXX := g++

HEADERS_DIRECTORY := include
INCLUDES := -I $(HEADERS_DIRECTORY)

CPPFLAGS := -pthread -Wall -Wextra -Wpedantic -Wnull-dereference -Wimplicit-fallthrough -Wmissing-include-dirs -Wswitch-default -Wuninitialized -Wunknown-pragmas -Wsuggest-attribute=noreturn -Wsuggest-final-types -Wsuggest-final-methods -Wsuggest-override -Walloc-zero -Wattribute-alias -Wduplicated-branches -Wduplicated-cond -Wfloat-equal -Wunused-macros -Wcast-align -Wdangling-else -Winline 
CFLAGS := -std=c11
CXXFLAGS := -std=c++17 -Wcatch-value -Wconditionally-supported -Wzero-as-null-pointer-constant -Wuseless-cast -Wdelete-incomplete -Wempty-body -Wenum-compare -Wextra-semi -Wno-virtual-move-assign

COMPILE.s := $(AS) $(ASFLAGS) $(TARGET_MACH)
COMPILE.c := $(CC) $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(TARGET_ARCH)
COMPILE.cc := $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(INCLUDES) $(TARGET_ARCH)

LIB_BOOST_PROGRAM_OPTIONS := -lboost_program_options
LIB_BOOST := $(LIB_BOOST_PROGRAM_OPTIONS)
LIB_MATH := -lm
LIB_PTHREAD := -lpthread
LIBS := $(LIB_BOOST) $(LIB_MATH) $(LIB_PTHREAD)
LDFLAGS := $(LIBS)
LINK.s := $(CC) $(ASFLAGS) $(LDFLAGS) $(TARGET_MACH)
LINK.S := $(CC) $(ASFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_MACH)
LINK.c := $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
LINK.cc := $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(INCLUDES) $(LDFLAGS) $(TARGET_ARCH)

all: copy

copy: copy.o
	$(LINK.cc) -o $@ $^

copy.o: copy.cpp
	$(COMPILE.cc) -c -o $@ $<

.PHONY: clean
clean:
	rm -rf *.o $(PROJECT)
