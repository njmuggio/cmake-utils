# MIT License
#
# Copyright (c) 2022 Nick Muggio
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

cmake_minimum_required(VERSION 3.12)

function(change_case case_type string output_variable)
  string(REGEX MATCHALL "([A-Z][a-z]*|[A-Z]+|[a-z]+|[0-9]+)" word_list "${string}")

  if (case_type STREQUAL "CAMEL")
    list(GET word_list 0 first_word)
    list(REMOVE_AT word_list 0)
    first_lower("${first_word}" result)

    foreach (word IN LISTS word_list)
      first_upper("${word}" word)
      string(APPEND result "${word}")
    endforeach()
  elseif (case_type STREQUAL "PASCAL")
    foreach (word IN LISTS word_list)
      first_upper("${word}" word)
      string(APPEND result "${word}")
    endforeach()
  elseif (case_type STREQUAL "SNAKE" OR case_type STREQUAL "DEAD_SNAKE")
    string(TOLOWER "${word_list}" word_list)
    list(JOIN word_list "_" result)
  elseif (case_type STREQUAL "SCREAMING_SNAKE")
    string(TOUPPER "${word_list}" word_list)
    list(JOIN word_list "_" result)
  elseif (case_type STREQUAL "KEBAB" OR case_type STREQUAL "DEAD_KEBAB")
    string(TOLOWER "${word_list}" word_list)
    list(JOIN word_list "-" result)
  elseif (case_type STREQUAL "SCREAMING_KEBAB")
    string(TOUPPER "${word_list}" word_list)
    list(JOIN word_list "-" result)
  else()
    message(WARNING "'${case_type}' is not a recognized case. Not modifying the string")
    set(result "${string}")
  endif()

  set(${output_variable} "${result}" PARENT_SCOPE)
endfunction()

function(first_lower string output_variable)
  string(SUBSTRING "${string}" 0 1 first_letter)
  string(TOLOWER "${first_letter}" first_letter)
  string(SUBSTRING "${string}" 1 -1 remaining)
  set(${output_variable} "${first_letter}${remaining}" PARENT_SCOPE)
endfunction()

function(first_upper string output_variable)
  string(SUBSTRING "${string}" 0 1 first_letter)
  string(TOUPPER "${first_letter}" first_letter)
  string(SUBSTRING "${string}" 1 -1 remaining)
  set(${output_variable} "${first_letter}${remaining}" PARENT_SCOPE)
endfunction()
