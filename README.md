# CMake Utilities

This repository contains a small, but hopefully-growing, set of utilities for
use with [CMake](https://cmake.org). All of the `*.cmake` files in the
repository root are designed to be copied into other CMake projects, and
included with `include()`. For example:

```cmake
cmake_minimum_required(VERSION 3.12)
project(NextBigThing VERSION 1.2.7)
include(change_case.cmake)
```

The following utilities are available, organized by script. See the scripts for
usage details.

* change_case.cmake
  * change_case
  * first_lower
  * first_upper
* git.cmake
  * git_details
