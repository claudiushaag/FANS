find_package(Python3 COMPONENTS Interpreter Development.Module REQUIRED)
# find_package(Python3 COMPONENTS Interpreter REQUIRED)

find_package(pybind11 REQUIRED)
find_package(MPI REQUIRED)                 # <-- this pulls in MPI headers & libs
include(GNUInstallDirs)


pybind11_add_module(PyFANS micro.hpp micro.cpp)
target_include_directories(PyFANS PRIVATE ${HDF5_INCLUDE_DIRS})
target_link_libraries(PyFANS PRIVATE FANS::FANS)


add_custom_command(
        TARGET PyFANS
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E create_symlink
        $<TARGET_FILE:PyFANS>
        ${CMAKE_CURRENT_SOURCE_DIR}/../test/test_pyfans/$<TARGET_FILE_NAME:PyFANS>
        COMMENT "Create a symlink for FANS python bindings to ${CMAKE_CURRENT_SOURCE_DIR}/../test/"
)

set(PY_INSTALL_DIR
    ${CMAKE_INSTALL_LIBDIR}/python${Python3_VERSION_MAJOR}.${Python3_VERSION_MINOR}/site-packages
)

install(TARGETS PyFANS
        LIBRARY DESTINATION ${PY_INSTALL_DIR}
        RUNTIME DESTINATION ${PY_INSTALL_DIR}
        ARCHIVE DESTINATION ${PY_INSTALL_DIR})
