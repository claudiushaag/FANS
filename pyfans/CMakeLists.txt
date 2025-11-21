find_package(pybind11 REQUIRED)
# find_package(Python REQUIRED COMPONENTS Interpreter Development)
find_package(MPI REQUIRED)                 # <-- this pulls in MPI headers & libs


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

install(TARGETS PyFANS
        LIBRARY DESTINATION lib          # *.so on Linux/macOS
        ARCHIVE DESTINATION lib          # *.a (import lib) on Windows
        RUNTIME DESTINATION bin)         # *.dll on Windows