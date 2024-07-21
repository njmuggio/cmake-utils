if (DEFINED UTILS_SOURCE_DIR AND DEFINED METHOD AND DEFINED EXPECTED_RESULT)
  include("${UTILS_SOURCE_DIR}/git.cmake")

  git_details("${METHOD}" result ${EXTRA_ARGS})

  list(JOIN EXTRA_ARGS " " extra_args_str)

  message("Method:          ${METHOD}")
  message("Extra args:      ${extra_args_str}")
  message("Result:          \"${result}\"")
  message("Expected result: \"${EXPECTED_RESULT}\"")

  if (result STREQUAL EXPECTED_RESULT)
    message("Test Passed")
  else()
    message("Test Failed")
  endif()

  return()
endif()

macro(test_git_details test_name method expected_result)
  add_test(
    NAME "${test_name}"
    COMMAND "${CMAKE_COMMAND}"
      -D "UTILS_SOURCE_DIR:PATH=${utils_SOURCE_DIR}"
      -D "METHOD:STRING=${method}"
      -D "EXPECTED_RESULT:STRING=${expected_result}"
      -D "EXTRA_ARGS:STRING=${ARGN}"
      -P "${CMAKE_CURRENT_LIST_FILE}"
  )
  set_tests_properties("${test_name}" PROPERTIES FAIL_REGULAR_EXPRESSION "Test Failed")
endmacro()

test_git_details(full_hash HASH f06cf7708b294773780d8c074bb6a6b7c11335fa REV f06cf7708b294773780d8c074bb6a6b7c11335fa LENGTH FULL)
test_git_details(short_hash HASH f06cf7708b REV f06cf7708b294773780d8c074bb6a6b7c11335fa LENGTH 10)
test_git_details(dirty_while_clean IS_DIRTY FALSE)
