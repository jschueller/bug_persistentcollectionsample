
OT_INSTALL_DIR=${HOME}/projects/openturns/schueller/build/install
OT_INCLUDE_DIR=${OT_INSTALL_DIR}/include
OT_LIB_DIR=${OT_INSTALL_DIR}/lib
CXXFLAGS=-fPIC
# flto


all : main dynamic_main

main.o: main.cxx
	g++ -I. -I$(OT_INCLUDE_DIR) $(CXXFLAGS) -c main.cxx -o $@

main: main.o libmini.so
	g++ -L. main.o -o $@ -lmini

mini.o: mini.hxx mini.cxx
	g++ -I$(OT_INCLUDE_DIR) $(CXXFLAGS) -c mini.cxx -o $@

libmini.so: mini.o
	g++ $^ -shared -o $@ -L$(OT_LIB_DIR) -lOT -Wl,-rpath $(OT_LIB_DIR)

dynamic_main.o: dynamic_main.cxx
	g++ -I$(OT_INCLUDE_DIR) $(CXXFLAGS) -c dynamic_main.cxx -o $@

dynamic_main: dynamic_main.o
	g++ dynamic_main.o -o $@ -ldl -L$(OT_LIB_DIR) -lOT -Wl,-rpath $(OT_LIB_DIR)

clean:
	rm -f main dynamic_main libmini.so mini.o main.o dynamic_main.o

run: dynamic_main main
	LD_LIBRARY_PATH=$(PWD):$(OT_LIB_DIR) ./main
	LD_LIBRARY_PATH=$(PWD):$(OT_LIB_DIR) ./dynamic_main
