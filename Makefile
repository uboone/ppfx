
OBJS_LIB = $(shell ls src/*.cpp | sed 's/\.cpp/.o/')
PROGS = $(shell ls src/*.C | sed 's/\.C//' | sed 's/src\///')
INCLUDES = -I./include -I$(shell root-config --incdir) -I$(BOOSTROOT) -I${DK2NU_INC}
DEPLIBS=$(shell root-config --libs) -lEG 

CC	=	g++
COPTS	=	-fPIC -DLINUX -O0  -g $(shell root-config --cflags) $(M32)
FLAGS   =       -g

all:    lib programs doxy

lib: libppfx.so 

libppfx.so: $(OBJS_LIB)
	if [ ! -d lib ]; then mkdir -p lib; fi

	$(CC) -shared $(M32) -o lib/$@ $^ -L${DK2NU_LIB} -ldk2nuTree


programs: $(PROGS)
	echo making $(PROGS)

$(PROGS): % : src/%.o $(OBJS_LIB)  libppfx.so
	if [ ! -d bin ]; then mkdir -p bin; fi

	$(CC) -Wall $(M32) -o bin/$@ $< $(PPFX_OBJS) $(DEPLIBS) -L$(PPFX_DIR)/lib -lppfx -L${DK2NU_LIB} -ldk2nuTree


%.o: %.cpp
	$(CC) $(COPTS) $(INCLUDES) -c -o $@ $<


%.o: %.C
	$(CC) $(COPTS) $(INCLUDES) -c -o $@ $<

%.o: %.cxx
	$(CC) $(COPTS) $(INCLUDES) -c -o $@ $<

doxy: 
	doxygen doxygen/config_doxygen

clean:  deldoxy delobj dellib delbin

delobj:
	-rm src/*.o

dellib:
	if [ -d lib ]; then rm -rf lib; fi 		

delbin:
	if [ -d bin ]; then rm -rf bin; fi

deldoxy:
	if [ -d html ]; then rm -rf html; fi
	if [ -d latex ]; then rm -rf latex; fi



