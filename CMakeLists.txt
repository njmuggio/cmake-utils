cmake_minimum_required(VERSION 3.12)
project(utils)

include(CTest)

if (BUILD_TESTING)
  add_subdirectory(test)
endif()
