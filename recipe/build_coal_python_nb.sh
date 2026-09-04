#!/bin/sh

rm -rf build
mkdir build

cd build

export GENERATE_PYTHON_STUBS=1
if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 ]]; then
  export GENERATE_PYTHON_STUBS=0
fi

# CMAKE_CXX_STANDARD hard coding should be removed in JRLv2
cmake ${CMAKE_ARGS} .. \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DPython_EXECUTABLE=$PYTHON \
      -DGENERATE_PYTHON_STUBS=$GENERATE_PYTHON_STUBS \
      -DBUILD_PYTHON_INTERFACE=ON \
      -DBUILD_STANDALONE_PYTHON_INTERFACE=ON \
      -DBUILD_TESTING=OFF \
      -DCOAL_PYTHON_NANOBIND=ON

ninja
ninja install

