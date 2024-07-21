# MIT License
#
# Copyright (c) 2024 Nick Muggio
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# To report issues or file feature requests, submit a ticket at
# https://github.com/njmuggio/cmake-utils/issues

cmake_minimum_required(VERSION 3.17)
include_guard(GLOBAL)
find_package(Git)

# Returns information regarding the a commit in a git project. If git is not
# found, or this function is not run inside a valid git repository, NOTFOUND
# will be returned.
#
# Synopsis:
# git_details(HASH <out-var> [REV <git-rev>] [LENGTH <length>])
# git_detauls(IS_DIRTY <out-var>)
#
# git_details(HASH ...)
#   Get the hash of the specified revision. REV defaults to "HEAD", but can be
#   any valid git revision. LENGTH can be used to control the number of
#   characters included in the hash. By default, git's automatic hash shortening
#   will be used. If LENGTH is "FULL", hash shortening will be disabled.
#
# git_details(IS_DIRTY ...)
#   Attempt to determine whether there have been any changes made since the
#   last commit. This includes both staged and unstaged changes, as well as new
#   non-ignored files.
function(git_details type out-var)
  set(${out-var} NOTFOUND PARENT_SCOPE)
  if (NOT GIT_FOUND)
    message(WARNING "${CMAKE_CURRENT_FUNCTION} was called, but git could not be found")
    return()
  endif()

  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse RESULT_VARIABLE git_invalid_repo OUTPUT_QUIET ERROR_QUIET)
  if (git_invalid_repo)
    message(WARNING "${CMAKE_CURRENT_FUNCTION} was called outside of a valid git repository")
    return()
  endif()

  macro(_check_err result error)
    if (result)
      message(WARNING "${CMAKE_CURRENT_FUNCTION}: git error: ${error}")
      return()
    endif()
  endmacro()

  if (type STREQUAL "HASH")
    cmake_parse_arguments(_ "" "REV;LENGTH" "" ${ARGN})
    if (NOT DEFINED __REV)
      set(__REV HEAD)
    endif()
    if (NOT DEFINED __LENGTH)
      set(__LENGTH --short)
    else()
      if (__LENGTH STREQUAL "FULL")
        unset(__LENGTH)
      else()
        set(__LENGTH "--short=${__LENGTH}")
      endif()
    endif()
    execute_process(
      COMMAND ${GIT_EXECUTABLE} rev-parse ${__LENGTH} ${__REV}
      RESULT_VARIABLE git_result
      OUTPUT_VARIABLE git_output
      ERROR_VARIABLE git_error
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_STRIP_TRAILING_WHITESPACE
    )
    _check_err(git_result git_error)
    set(${out-var} "${git_output}" PARENT_SCOPE)
  elseif (type STREQUAL "IS_DIRTY")
    execute_process(
      COMMAND ${GIT_EXECUTABLE} status --porcelain
      RESULT_VARIABLE git_result
      OUTPUT_VARIABLE git_output
      ERROR_VARIABLE git_error
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_STRIP_TRAILING_WHITESPACE
    )
    _check_err(git_result git_error)
    if (git_output STREQUAL "")
      set(${out-var} FALSE PARENT_SCOPE)
    else()
      set(${out-var} TRUE PARENT_SCOPE)
    endif()
  endif()
endfunction()
