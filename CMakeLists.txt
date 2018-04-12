cmake_minimum_required(VERSION 3.8)
project(arch_task2)

set(CMAKE_C_STANDARD 99)

set(SOURCE_FILES main.c headers.h)
add_executable(arch_task2 ${SOURCE_FILES})
target_link_libraries(arch_task2 m)
