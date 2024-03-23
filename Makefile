CXX = g++
CXX_FLAGS = -save-temps -O2
LD_FLAGS = -g # -L<LibraryPath_1> -L<LibraryPath_2>

#LD_LIBS = -l<LibraryName_1> -l<LibraryName_2>

MAKE_FILE_ROOT = ${PWD}
INSTALL_DIRECTORY = ${MAKE_FILE_ROOT}/build
TEMP_DIRECTORY = ${MAKE_FILE_ROOT}/temp
APP_NAME = application 


all: link compile

link: compile
	cd ${TEMP_DIRECTORY}; \
	${CXX} ${TEMP_DIRECTORY}/Main.o -o ${APP_NAME} ${LD_FLAGS}

compile:
	mkdir ${TEMP_DIRECTORY}; \
	cd ${TEMP_DIRECTORY}; \
	${CXX} -c ${MAKE_FILE_ROOT}/src/Main.cpp -o Main.o ${CXX_FLAGS}

install:
	cp -pr ${TEMP_DIRECTORY}/${APP_NAME} ${INSTALL_DIRECTORY}/. 

clean: 
	rm -rf ${TEMP_DIRECTORY}/*; \
	rm -rf ${INSTALL_DIRECTORY}/${APP_NAME} 
