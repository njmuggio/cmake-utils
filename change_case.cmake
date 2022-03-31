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
#
# To report issues or file feature requests, submit a ticket at
# https://github.com/njmuggio/cmake-utils/issues

cmake_minimum_required(VERSION 3.12)

# Changes the case of a string.
#
# This strips out all non-alphanumeric characters. This function works best with
# english inputs, as 'A' and 'I' are treated specially. For example, given the
# inputs "YesISuppose" or "HaveAGo", three words will be identified: "Yes I
# Suppose" and "Have A Go", respectively.
#
# Arguments:
#   case_type: One of {CAMEL, PASCAL, SNAKE, DEAD_SNAKE, SCREAMING_SNAKE,
#              KEBAB, DEAD_KEBAB, SCREAMING_KEBAB, PROSE, SENTENCE, TITLE}
#   string: String to convert
#   output_variable: Name of the output variable
#
# Example outputs for each case type:
# - CAMEL: abc123Xyz789
# - PASCAL: Abc123Xyz789
# - SNAKE/DEAD_SNAKE: abc_123_xyz_789
# - SCREAMING_SNAKE: ABC_123_XYZ_789
# - KEBAB/DEAD_KEBAB: abc-123-xyz-789
# - SCREAMING_KEBAB: ABC-123-XYZ-789
# - PROSE: abc 123 xyz 789
# - SENTENCE: Abc 123 xyz 789
# - TITLE: Abc 123 Xyz 789
function(change_case case_type string output_variable)
  string(REGEX MATCHALL "([a-zA-Z0-9]+)" chunk_list "${string}")

  foreach (chunk IN LISTS chunk_list)
    if (chunk MATCHES "^([a-z]+|[A-Z]+|[0-9]+)$")
      list(APPEND word_list "${chunk}")
    else()
      string(REGEX MATCHALL "([0-9]+|[AI]?[A-Z]?[a-z]+|[A-Z]+)" sub_chunk_list "${chunk}")
      foreach (sub_chunk IN LISTS sub_chunk_list)
        if (sub_chunk MATCHES "^[AI][A-Z]")
          string(SUBSTRING "${sub_chunk}" 0 1 first_letter)
          list(APPEND word_list "${first_letter}")
          string(SUBSTRING "${sub_chunk}" 1 -1 remaining)
          list(APPEND word_list "${remaining}")
        else()
          list(APPEND word_list "${sub_chunk}")
        endif()
      endforeach()
    endif()
  endforeach()

  if (case_type STREQUAL "CAMEL")
    list(GET word_list 0 first_word)
    list(REMOVE_AT word_list 0)
    string(TOLOWER "${first_word}" result)

    foreach (word IN LISTS word_list)
      string(TOLOWER "${word}" word)
      first_upper("${word}" word)
      string(APPEND result "${word}")
    endforeach()
  elseif (case_type STREQUAL "PASCAL")
    foreach (word IN LISTS word_list)
      string(TOLOWER "${word}" word)
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
  elseif (case_type STREQUAL "PROSE")
    string(TOLOWER "${word_list}" word_list)
    list(JOIN word_list " " result)
  elseif (case_type STREQUAL "SENTENCE")
    string(TOLOWER "${word_list}" word_list)
    first_upper("${word_list}" word_list)
    list(JOIN word_list " " result)
  elseif (case_type STREQUAL "TITLE")
    string(TOLOWER "${word_list}" word_list)

    foreach (word IN LISTS word_list)
      first_upper("${word}" word)
      string(APPEND result " ${word}")
    endforeach()

    string(SUBSTRING "${result}" 1 -1 result)
  else()
    message(WARNING "'${case_type}' is not a recognized case. Not modifying the string")
    set(result "${string}")
  endif()

  set(${output_variable} "${result}" PARENT_SCOPE)
endfunction()

# Lower-case the first character in a string.
function(first_lower string output_variable)
  string(SUBSTRING "${string}" 0 1 first_letter)
  string(TOLOWER "${first_letter}" first_letter)
  string(SUBSTRING "${string}" 1 -1 remaining)
  set(${output_variable} "${first_letter}${remaining}" PARENT_SCOPE)
endfunction()

# Upper-case the first character in a string.
function(first_upper string output_variable)
  string(SUBSTRING "${string}" 0 1 first_letter)
  string(TOUPPER "${first_letter}" first_letter)
  string(SUBSTRING "${string}" 1 -1 remaining)
  set(${output_variable} "${first_letter}${remaining}" PARENT_SCOPE)
endfunction()
