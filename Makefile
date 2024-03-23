CXX = g++
CXX_FLAGS = -O2 -Wall -Werror -std=c++17 -save-temps -DDEBUG=0
LD_FLAGS = -g # -L<LibraryPath_1> -L<LibraryPath_2>

#LD_LIBS = -l<LibraryName_1> -l<LibraryName_2>

MAKE_FILE_ROOT = ${PWD}
INSTALL_DIRECTORY = ${MAKE_FILE_ROOT}/build
TEMP_DIRECTORY = ${MAKE_FILE_ROOT}/temp
SRC_DIRECTORY = ${MAKE_FILE_ROOT}/src

SRC_FILES = `ls ${SRC_DIRECTORY}/*.cpp`
OBJ_FILES = `ls ${TEMP_DIRECTORY}/*.o`

APP_NAME = application 

all: link compile

link: compile
	cd ${TEMP_DIRECTORY}; \
	${CXX} ${OBJ_FILES} -o ${APP_NAME} ${LD_FLAGS}

compile:
	mkdir ${TEMP_DIRECTORY}; \
	cd ${TEMP_DIRECTORY}; \
	${CXX} -c ${SRC_FILES} ${CXX_FLAGS}

install:
	cp -pr ${TEMP_DIRECTORY}/${APP_NAME} ${INSTALL_DIRECTORY}/. 

clean: 
	rm -rf ${TEMP_DIRECTORY}/*; \
	rm -rf ${INSTALL_DIRECTORY}/${APP_NAME} 
