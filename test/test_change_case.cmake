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

#iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD
#IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD
#i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD
#I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD
#i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD
#I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD

test_change_case(camel_1 CAMEL "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"                              "iClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(camel_2 CAMEL "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"                              "iClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(camel_3 CAMEL "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD"                     "iClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(camel_4 CAMEL "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD"                     "iClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(camel_5 CAMEL "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD"                     "iClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(camel_6 CAMEL "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD"                     "iClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")

test_change_case(pascal_1 PASCAL "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"                            "IClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(pascal_2 PASCAL "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"                            "IClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(pascal_3 PASCAL "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD"                   "IClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(pascal_4 PASCAL "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD"                   "IClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(pascal_5 PASCAL "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD"                   "IClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")
test_change_case(pascal_6 PASCAL "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD"                   "IClaimThisIsAStringIInterfaceAioli123XyzAAbstractionsLittlewordBigword")

test_change_case(snake_1 SNAKE "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"                              "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(snake_2 SNAKE "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"                              "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(snake_3 SNAKE "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD"                     "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(snake_4 SNAKE "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD"                     "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(snake_5 SNAKE "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD"                     "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(snake_6 SNAKE "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD"                     "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")

test_change_case(dead_snake_1 DEAD_SNAKE "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"                    "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(dead_snake_2 DEAD_SNAKE "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"                    "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(dead_snake_3 DEAD_SNAKE "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD"           "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(dead_snake_4 DEAD_SNAKE "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD"           "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(dead_snake_5 DEAD_SNAKE "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD"           "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")
test_change_case(dead_snake_6 DEAD_SNAKE "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD"           "i_claim_this_is_a_string_i_interface_aioli_123_xyz_a_abstractions_littleword_bigword")

test_change_case(screaming_snake_1 SCREAMING_SNAKE "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"          "I_CLAIM_THIS_IS_A_STRING_I_INTERFACE_AIOLI_123_XYZ_A_ABSTRACTIONS_LITTLEWORD_BIGWORD")
test_change_case(screaming_snake_2 SCREAMING_SNAKE "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"          "I_CLAIM_THIS_IS_A_STRING_I_INTERFACE_AIOLI_123_XYZ_A_ABSTRACTIONS_LITTLEWORD_BIGWORD")
test_change_case(screaming_snake_3 SCREAMING_SNAKE "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD" "I_CLAIM_THIS_IS_A_STRING_I_INTERFACE_AIOLI_123_XYZ_A_ABSTRACTIONS_LITTLEWORD_BIGWORD")
test_change_case(screaming_snake_4 SCREAMING_SNAKE "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD" "I_CLAIM_THIS_IS_A_STRING_I_INTERFACE_AIOLI_123_XYZ_A_ABSTRACTIONS_LITTLEWORD_BIGWORD")
test_change_case(screaming_snake_5 SCREAMING_SNAKE "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD" "I_CLAIM_THIS_IS_A_STRING_I_INTERFACE_AIOLI_123_XYZ_A_ABSTRACTIONS_LITTLEWORD_BIGWORD")
test_change_case(screaming_snake_6 SCREAMING_SNAKE "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD" "I_CLAIM_THIS_IS_A_STRING_I_INTERFACE_AIOLI_123_XYZ_A_ABSTRACTIONS_LITTLEWORD_BIGWORD")

test_change_case(kebab_1 KEBAB "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"                              "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(kebab_2 KEBAB "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"                              "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(kebab_3 KEBAB "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD"                     "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(kebab_4 KEBAB "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD"                     "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(kebab_5 KEBAB "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD"                     "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(kebab_6 KEBAB "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD"                     "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")

test_change_case(dead_kebab_1 DEAD_KEBAB "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"                    "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(dead_kebab_2 DEAD_KEBAB "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"                    "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(dead_kebab_3 DEAD_KEBAB "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD"           "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(dead_kebab_4 DEAD_KEBAB "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD"           "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(dead_kebab_5 DEAD_KEBAB "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD"           "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")
test_change_case(dead_kebab_6 DEAD_KEBAB "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD"           "i-claim-this-is-a-string-i-interface-aioli-123-xyz-a-abstractions-littleword-bigword")

test_change_case(screaming_kebab_1 SCREAMING_KEBAB "iClaimThisIsAString *!@$& iInterface aioli123Xyz aAbstractions littleword BIGWORD"          "I-CLAIM-THIS-IS-A-STRING-I-INTERFACE-AIOLI-123-XYZ-A-ABSTRACTIONS-LITTLEWORD-BIGWORD")
test_change_case(screaming_kebab_2 SCREAMING_KEBAB "IClaimThisIsAString *!@$& IInterface Aioli123Xyz AAbstractions littleword BIGWORD"          "I-CLAIM-THIS-IS-A-STRING-I-INTERFACE-AIOLI-123-XYZ-A-ABSTRACTIONS-LITTLEWORD-BIGWORD")
test_change_case(screaming_kebab_3 SCREAMING_KEBAB "i_claim_this_is_a_string *!@$& i_interface aioli_123_xyz a_abstractions littleword BIGWORD" "I-CLAIM-THIS-IS-A-STRING-I-INTERFACE-AIOLI-123-XYZ-A-ABSTRACTIONS-LITTLEWORD-BIGWORD")
test_change_case(screaming_kebab_4 SCREAMING_KEBAB "I_CLAIM_THIS_IS_A_STRING *!@$& I_INTERFACE AIOLI_123_XYZ A_ABSTRACTIONS littleword BIGWORD" "I-CLAIM-THIS-IS-A-STRING-I-INTERFACE-AIOLI-123-XYZ-A-ABSTRACTIONS-LITTLEWORD-BIGWORD")
test_change_case(screaming_kebab_5 SCREAMING_KEBAB "i-claim-this-is-a-string *!@$& i-interface aioli-123-xyz a-abstractions littleword BIGWORD" "I-CLAIM-THIS-IS-A-STRING-I-INTERFACE-AIOLI-123-XYZ-A-ABSTRACTIONS-LITTLEWORD-BIGWORD")
test_change_case(screaming_kebab_6 SCREAMING_KEBAB "I-CLAIM-THIS-IS-A-STRING *!@$& I-INTERFACE AIOLI-123-XYZ A-ABSTRACTIONS littleword BIGWORD" "I-CLAIM-THIS-IS-A-STRING-I-INTERFACE-AIOLI-123-XYZ-A-ABSTRACTIONS-LITTLEWORD-BIGWORD")
