# -- User inputs -- #
MPI = 0
DEBUG = 0

#LD_FLAGS = -L<LibraryPath_1> -L<LibraryPath_2>
#LD_LIBS = -l<LibraryName_1> -l<LibraryName_2>
#MISC_CXX_FLAGS = 

# ----------------- #

CC = gcc
CXX = g++

ifeq (${MPI},1)
	CC = mpicc
	CXX = mpic++ 
endif

CXX_FLAGS = -O2 -g -Wall -Werror -std=c++17 -save-temps -DPR_DEBUG=${DEBUG} -DMPI_APP=${MPI} ${MISC_CXX_FLAGS}

# --------------------------------------------------------------------------------------- #

MAKE_FILE_ROOT = ${PWD}
INSTALL_DIRECTORY = ${MAKE_FILE_ROOT}/build
TEMP_DIRECTORY = ${MAKE_FILE_ROOT}/temp
SRC_DIRECTORY = ${MAKE_FILE_ROOT}/src

SRC_FILES = `ls ${SRC_DIRECTORY}/*.cpp`	# contain absolute paths
OBJ_FILES = `ls ${TEMP_DIRECTORY}/*.o`	# contain absolute paths

APP_NAME = application 

all: link compile

link: compile
	cd ${TEMP_DIRECTORY}; \
	${CXX} ${OBJ_FILES} -o ${APP_NAME} ${LD_FLAGS} ${LD_LIBS}

compile:
	mkdir ${TEMP_DIRECTORY}; \
	cd ${TEMP_DIRECTORY}; \
	${CXX} -c ${SRC_FILES} ${CXX_FLAGS}

install:
	cp -pr ${TEMP_DIRECTORY}/${APP_NAME} ${INSTALL_DIRECTORY}/. 

clean: 
	rm -rf ${TEMP_DIRECTORY}/*; \
	rm -rf ${INSTALL_DIRECTORY}/${APP_NAME} 
