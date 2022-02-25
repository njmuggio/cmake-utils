if (DEFINED UTILS_SOURCE_DIR AND DEFINED CASE_TYPE AND DEFINED EXPECTED_RESULT AND DEFINED TEST_INPUT)
  include("${UTILS_SOURCE_DIR}/change_case.cmake")

  change_case("${CASE_TYPE}" "${TEST_INPUT}" result)

  message("Case type:        ${CASE_TYPE}")
  message("Result:          \"${result}\"")
  message("Expected result: \"${EXPECTED_RESULT}\"")

  if (result STREQUAL EXPECTED_RESULT)
    message("Test Passed")
  else()
    message("Test Failed")
  endif()

  return()
endif()

macro(test_change_case test_name case_type string expected_result)
  add_test(
    NAME "${test_name}"
    COMMAND "${CMAKE_COMMAND}"
      -D "UTILS_SOURCE_DIR:PATH=${utils_SOURCE_DIR}"
      -D "CASE_TYPE:STRING=${case_type}"
      -D "EXPECTED_RESULT:STRING=${expected_result}"
      -D "TEST_INPUT:STRING=${string}"
      -P "${CMAKE_CURRENT_LIST_FILE}"
  )
  set_tests_properties("${test_name}" PROPERTIES FAIL_REGULAR_EXPRESSION "Test Failed")
endmacro()

test_change_case(unrecognized_case NOT_A_CASE "This shall not be changed" "This shall not be changed")

test_change_case(camel_1 CAMEL "abcdefg" "abcdefg")
test_change_case(camel_2 CAMEL "abcdEfg" "abcdEfg")
test_change_case(camel_3 CAMEL "AbcdEfg" "abcdEfg")
test_change_case(camel_4 CAMEL "abcd efg" "abcdEfg")
test_change_case(camel_5 CAMEL "abcd_efg" "abcdEfg")
test_change_case(camel_6 CAMEL "abcd123" "abcd123")
test_change_case(camel_7 CAMEL "abcd123efg" "abcd123Efg")
test_change_case(camel_8 CAMEL "abcd::efg" "abcdEfg")
test_change_case(camel_9 CAMEL "abcd 123 __ !@$ efg" "abcd123Efg")

test_change_case(pascal_1 PASCAL "abcdefg" "Abcdefg")
test_change_case(pascal_2 PASCAL "abcdEfg" "AbcdEfg")
test_change_case(pascal_3 PASCAL "AbcdEfg" "AbcdEfg")
test_change_case(pascal_4 PASCAL "abcd efg" "AbcdEfg")
test_change_case(pascal_5 PASCAL "abcd_efg" "AbcdEfg")
test_change_case(pascal_6 PASCAL "abcd123" "Abcd123")
test_change_case(pascal_7 PASCAL "abcd123efg" "Abcd123Efg")
test_change_case(pascal_8 PASCAL "abcd::efg" "AbcdEfg")
test_change_case(pascal_9 PASCAL "abcd 123 __ !@$ efg" "Abcd123Efg")

test_change_case(snake_1 SNAKE "abcdefg" "abcdefg")
test_change_case(snake_2 SNAKE "abcdEfg" "abcd_efg")
test_change_case(snake_3 SNAKE "AbcdEfg" "abcd_efg")
test_change_case(snake_4 SNAKE "abcd efg" "abcd_efg")
test_change_case(snake_5 SNAKE "abcd_efg" "abcd_efg")
test_change_case(snake_6 SNAKE "abcd123" "abcd_123")
test_change_case(snake_7 SNAKE "abcd123efg" "abcd_123_efg")
test_change_case(snake_8 SNAKE "abcd::efg" "abcd_efg")
test_change_case(snake_9 SNAKE "abcd 123 __ !@$ efg" "abcd_123_efg")

test_change_case(dead_snake_1 DEAD_SNAKE "abcdefg" "abcdefg")
test_change_case(dead_snake_2 DEAD_SNAKE "abcdEfg" "abcd_efg")
test_change_case(dead_snake_3 DEAD_SNAKE "AbcdEfg" "abcd_efg")
test_change_case(dead_snake_4 DEAD_SNAKE "abcd efg" "abcd_efg")
test_change_case(dead_snake_5 DEAD_SNAKE "abcd_efg" "abcd_efg")
test_change_case(dead_snake_6 DEAD_SNAKE "abcd123" "abcd_123")
test_change_case(dead_snake_7 DEAD_SNAKE "abcd123efg" "abcd_123_efg")
test_change_case(dead_snake_8 DEAD_SNAKE "abcd::efg" "abcd_efg")
test_change_case(dead_snake_9 DEAD_SNAKE "abcd 123 __ !@$ efg" "abcd_123_efg")

test_change_case(screaming_snake_1 SCREAMING_SNAKE "abcdefg" "ABCDEFG")
test_change_case(screaming_snake_2 SCREAMING_SNAKE "abcdEfg" "ABCD_EFG")
test_change_case(screaming_snake_3 SCREAMING_SNAKE "AbcdEfg" "ABCD_EFG")
test_change_case(screaming_snake_4 SCREAMING_SNAKE "abcd efg" "ABCD_EFG")
test_change_case(screaming_snake_5 SCREAMING_SNAKE "abcd_efg" "ABCD_EFG")
test_change_case(screaming_snake_6 SCREAMING_SNAKE "abcd123" "ABCD_123")
test_change_case(screaming_snake_7 SCREAMING_SNAKE "abcd123efg" "ABCD_123_EFG")
test_change_case(screaming_snake_8 SCREAMING_SNAKE "abcd::efg" "ABCD_EFG")
test_change_case(screaming_snake_9 SCREAMING_SNAKE "abcd 123 __ !@$ efg" "ABCD_123_EFG")

test_change_case(kebab_1 KEBAB "abcdefg" "abcdefg")
test_change_case(kebab_2 KEBAB "abcdEfg" "abcd-efg")
test_change_case(kebab_3 KEBAB "AbcdEfg" "abcd-efg")
test_change_case(kebab_4 KEBAB "abcd efg" "abcd-efg")
test_change_case(kebab_5 KEBAB "abcd_efg" "abcd-efg")
test_change_case(kebab_6 KEBAB "abcd123" "abcd-123")
test_change_case(kebab_7 KEBAB "abcd123efg" "abcd-123-efg")
test_change_case(kebab_8 KEBAB "abcd::efg" "abcd-efg")
test_change_case(kebab_9 KEBAB "abcd 123 __ !@$ efg" "abcd-123-efg")

test_change_case(dead_kebab_1 DEAD_KEBAB "abcdefg" "abcdefg")
test_change_case(dead_kebab_2 DEAD_KEBAB "abcdEfg" "abcd-efg")
test_change_case(dead_kebab_3 DEAD_KEBAB "AbcdEfg" "abcd-efg")
test_change_case(dead_kebab_4 DEAD_KEBAB "abcd efg" "abcd-efg")
test_change_case(dead_kebab_5 DEAD_KEBAB "abcd_efg" "abcd-efg")
test_change_case(dead_kebab_6 DEAD_KEBAB "abcd123" "abcd-123")
test_change_case(dead_kebab_7 DEAD_KEBAB "abcd123efg" "abcd-123-efg")
test_change_case(dead_kebab_8 DEAD_KEBAB "abcd::efg" "abcd-efg")
test_change_case(dead_kebab_9 DEAD_KEBAB "abcd 123 __ !@$ efg" "abcd-123-efg")

test_change_case(screaming_kebab_1 SCREAMING_KEBAB "abcdefg" "ABCDEFG")
test_change_case(screaming_kebab_2 SCREAMING_KEBAB "abcdEfg" "ABCD-EFG")
test_change_case(screaming_kebab_3 SCREAMING_KEBAB "AbcdEfg" "ABCD-EFG")
test_change_case(screaming_kebab_4 SCREAMING_KEBAB "abcd efg" "ABCD-EFG")
test_change_case(screaming_kebab_5 SCREAMING_KEBAB "abcd_efg" "ABCD-EFG")
test_change_case(screaming_kebab_6 SCREAMING_KEBAB "abcd123" "ABCD-123")
test_change_case(screaming_kebab_7 SCREAMING_KEBAB "abcd123efg" "ABCD-123-EFG")
test_change_case(screaming_kebab_8 SCREAMING_KEBAB "abcd::efg" "ABCD-EFG")
test_change_case(screaming_kebab_9 SCREAMING_KEBAB "abcd 123 __ !@$ efg" "ABCD-123-EFG")
