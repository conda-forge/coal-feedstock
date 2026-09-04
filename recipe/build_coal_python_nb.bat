rm -rf build

mkdir build
cd build

:: CMAKE_CXX_STANDARD hard coding should be removed in JRLv2
cmake %SRC_DIR% ^
    -GNinja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DPython_SITELIB=%SP_DIR% ^
    -DPython_EXECUTABLE=%PYTHON% ^
    -DGENERATE_PYTHON_STUBS=ON ^
    -DBUILD_PYTHON_INTERFACE=ON ^
    -DBUILD_STANDALONE_PYTHON_INTERFACE=ON ^
    -DBUILD_TESTING=OFF ^
    -DCOAL_PYTHON_NANOBIND=ON

if errorlevel 1 exit 1

:: Build.
ninja
if errorlevel 1 exit 1

:: Install.
ninja install
if errorlevel 1 exit 1

