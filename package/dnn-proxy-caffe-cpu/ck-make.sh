#! /bin/bash

#
# Make script for CK libraries
# (depends on configured/installed compilers via CK)
#
# See CK LICENSE.txt for licensing details.
# See CK Copyright.txt for copyright details.
#
# Developer(s): Grigori Fursin, 2015
#

export CK_SOURCE_FILES="dnn_proxy.cpp"
export CK_OBJ_FILES=dnn_proxy${CK_OBJ_EXT}
export CK_INCLUDE_FILE=dnn_proxy.h

export LIB_NAME=libdnnproxy

export CK_INC_BOOST="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_BOOST_INCLUDE}"
export CK_INC_BLAS="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_OPENBLAS_INCLUDE}"
export CK_INC_CAFFE="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_CAFFE_INCLUDE}"
export CK_INC_GFLAGS="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_GFLAGS_INCLUDE}"
export CK_INC_GLOG="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_GLOG_INCLUDE}"
export CK_INC_OPENCV="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_OPENCV_INCLUDE}"
export CK_INC_PROTOBUF="${CK_FLAG_PREFIX_INCLUDE}${CK_ENV_LIB_PROTOBUF_HOST_INCLUDE}"
export CK_INC_LOCAL="${CK_FLAG_PREFIX_INCLUDE} ."
export CK_COMPILER_FLAGS_MISC="${CK_INC_BOOST} ${CK_INC_BLAS} ${CK_INC_CAFFE} ${CK_INC_GFLAGS} ${CK_INC_GLOG} ${CK_INC_OPENCV} ${CK_INC_PROTOBUF} ${CK_INC_LOCAL} ${CK_COMPILER_FLAGS_MISC}"

export CK_LIB_BOOST="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_BOOST_LIB} ${CK_ENV_LIB_BOOST_LFLAG_SYSTEM}"
export CK_LIB_BLAS="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_OPENBLAS_LIB} -lopenblas"
export CK_LIB_CAFFE="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_CAFFE_LIB} -lcaffe"
export CK_LIB_GFLAGS="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_GFLAGS_LIB} ${CK_ENV_LIB_GFLAGS_LFLAG}"
export CK_LIB_GLOG="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_GLOG_LIB} ${CK_ENV_LIB_GLOG_LFLAG}"
export CK_LIB_OPENCV="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_OPENCV_LIB} ${CK_ENV_LIB_OPENCV_LFLAG_CORE} ${CK_ENV_LIB_OPENCV_LFLAG_HIGHGUI} ${CK_ENV_LIB_OPENCV_LFLAG_IMGPROC}"
export CK_LIB_PROTOBUF="${CK_FLAG_PREFIX_LIB_DIR}${CK_ENV_LIB_PROTOBUF_HOST_LIB} ${CK_ENV_LIB_PROTOBUF_HOST_LFLAG}"
export CK_LD_FLAGS_MISC="${CK_LIB_BOOST} ${CK_LIB_BLAS} ${CK_LIB_CAFFE} ${CK_LIB_GFLAGS} ${CK_LIB_GLOG} ${CK_LIB_OPENCV} ${CK_LIB_PROTOBUF} ${CK_LD_FLAGS_MISC}"



echo ""
echo "Building static library ..."
echo ""

export CK_TARGET_FILE=${LIB_NAME}${CK_LIB_EXT}
export CK_TARGET_FILE_S=${CK_TARGET_FILE}

export CK_CC_FLAGS="${CK_COMPILER_FLAGS_OBLIGATORY} ${CK_COMPILER_FLAGS_MISC} ${CK_COMPILER_FLAGS_CC_OPTS} ${CK_COMPILER_FLAGS_ARCH} ${CK_COMPILER_FLAGS_PAR}"

echo "Executing ${CK_CC} ${CK_OPT_SPEED} ${CK_FLAGS_STATIC_LIB} ${CK_FLAGS_CREATE_OBJ} ${CK_CC_FLAGS} ${CK_SOURCE_FILES} ${CK_LD_FLAGS_MISC} ${CK_LD_FLAGS_EXTRA}"
${CK_CC} ${CK_OPT_SPEED} ${CK_FLAGS_STATIC_LIB} ${CK_FLAGS_CREATE_OBJ} ${CK_CC_FLAGS} ${CK_SOURCE_FILES} ${CK_LD_FLAGS_MISC} ${CK_LD_FLAGS_EXTRA}
  if [ "${?}" != "0" ] ; then
    echo "Error: Compilation failed in $PWD!" 
    exit 1
  fi

echo "Executing ${CK_LB} ${CK_LB_OUTPUT}${CK_TARGET_FILE} ${CK_OBJ_FILES}"
${CK_LB} ${CK_LB_OUTPUT}${CK_TARGET_FILE} ${CK_OBJ_FILES}
  if [ "${?}" != "0" ] ; then
    echo "Error: Compilation failed in $PWD!" 
    exit 1
  fi




echo ""
echo "Building dynamic library ..."
echo ""

export CK_TARGET_FILE=${LIB_NAME}${CK_DLL_EXT}
export CK_TARGET_FILE_D=${CK_TARGET_FILE}

export CK_CC_FLAGS="${CK_COMPILER_FLAGS_OBLIGATORY} ${CK_COMPILER_FLAGS_MISC} ${CK_COMPILER_FLAGS_CC_OPTS} ${CK_COMPILER_FLAGS_ARCH} ${CK_COMPILER_FLAGS_PAR}"

echo "Executing ${CK_CC} ${CK_OPT_SPEED} ${CK_FLAGS_DLL} ${CK_CC_FLAGS} ${CK_SOURCE_FILES} ${CK_FLAGS_OUTPUT}${CK_TARGET_FILE} ${CK_FLAGS_DLL_EXTRA} ${CK_LD_FLAGS_MISC} ${CK_LD_FLAGS_EXTRA}"
${CK_CC} ${CK_OPT_SPEED} ${CK_FLAGS_DLL} ${CK_CC_FLAGS} ${CK_SOURCE_FILES} ${CK_FLAGS_OUTPUT}${CK_TARGET_FILE} ${CK_FLAGS_DLL_EXTRA} ${CK_LD_FLAGS_MISC} ${CK_LD_FLAGS_EXTRA}
  if [ "${?}" != "0" ] ; then
    echo "Error: Compilation failed in $PWD!" 
    exit 1
  fi




echo ""
echo "Installing ..."
echo ""

mkdir ${INSTALL_DIR}/lib
cp -f ${CK_TARGET_FILE_S} ${INSTALL_DIR}/lib
cp -f ${CK_TARGET_FILE_D} ${INSTALL_DIR}/lib

mkdir ${INSTALL_DIR}/include
cp ${CK_INCLUDE_FILE} ${INSTALL_DIR}/include