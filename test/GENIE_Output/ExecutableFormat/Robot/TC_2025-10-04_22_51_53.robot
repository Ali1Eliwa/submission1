*** Settings ***
Resource   ../../Helpers/Keyword/Initialization.resource

#Suite Setup         Security_Initialization   
#Suite Teardown      Clean Environment

*** Variables ***
${SECURITYM_VERIFY_OK} =   ${0}
${SECURITYM_VERIFY_NOK} =  ${1}
${SystemP_FAILURE} =       ${-1}
${Positive} =              ${True}
@{KEY_FIXED_VALUE} =       ${2}    ${31}    ${32}    ${12}    ${72}    ${203}     ${79}    ${33}     ${70}    ${70}    ${5}    ${173}    ${41}    ${107}    ${173}
${index} =                 ${0}
${DEC_3_2023}              1701604800
${FEB_14_2024}             1707912000
${FEB_27_2024}             1709022000
*** Test Cases ***
#artf2155594 / artf2165066 
SwIT_VCore_F6_VBOOT_CMAC_HSM_0001
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that vBOOT shall authenticate the vHSM using the HSM_CMAC
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_451, CSC_2015_452
  ...  aTestGoal: Checking the authentication of vHSM using HSM_CMAC

  Initialize Communication    vboot
  HSM should be authenticated using HSM_CMAC
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0002
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that HSM shall authenticate R5 core
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_201, CSC_2015_211
  ...  aTestGoal: Checking the authentication of R5 core by HSM

  Initialize Communication    r5
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for R5
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  Should Be True    HSM  shall authenticate the R5 autosar
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0003
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that HSM shall authenticate M4 core
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_201, CSC_2015_211
  ...  aTestGoal: Checking the authentication of M4 core by HSM

  Initialize Communication    m4
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for M4
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  Should Be True    HSM  shall authenticate the M4 autosar
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0004
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that the system should be reseted if the authentication failed for first time for R5
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_201, CSC_2015_211
  ...  aTestGoal: Checking that if authentication failed for first time for R5 the system should be reseted

  Initialize Communication    r5
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for R5
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  Should Be True    the system is reseted
  log the reason of failed
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0005
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that the system should be reseted if the authentication failed for first time for M4
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_201, CSC_2015_211
  ...  aTestGoal: Checking that if authentication failed for first time for M4 the system should be reseted

  Initialize Communication    m4
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for M4
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  Should Be True    the system is reseted
  log the reason of failed
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0006
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that the system should put in bootloader mode if the authentication failed for second time for R5
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_201, CSC_2015_211
  ...  aTestGoal: Checking that if authentication failed for second time for R5 the system will be in bootloader mode

  Initialize Communication    r5
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for R5
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  Should Be True    the system is reseted
  log the reason of failed

  Initialize Communication    r5
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  Should Be True    the system is in the bootloader mode
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0007
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that the system should put in bootloader mode if the authentication failed for second time for M4
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_201, CSC_2015_211
  ...  aTestGoal: Checking that if authentication failed for second time for M4 the system will be in bootloader mode

  Initialize Communication    m4
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for M4
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  Should Be True    the system is reseted
  log the reason of failed

  Initialize Communication    m4
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  Should Be True    the system is in the bootloader mode
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0008
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking the authentication of A53 once the R5 verified
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_202
  ...  aTestGoal: Checking the authentication of A53 using the verification of R5

  Initialize Communication    a53
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for R5
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  Should Be True    HSM  shall authenticate the R5 autosar
  #for BL 31
  Checking hash for BL 31 using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for BL 31 of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for BL 33
  Checking hash for BL 33 using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for BL 33 of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for Kernel
  Checking hash for Kernel using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for Kernel of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for Linux device tree 
  Checking hash for Linux device tree using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for Linux device tree of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for InitRamFS
  Checking hash for InitRamFS using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for InitRamFS of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for Application
  Checking hash for Application using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for Application of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  Should Be True    A53 should be authenticated
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0009
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that the system should be reseted if the authentication failed of BL 31 for first time for A53
  ...  aTestGroup: F6_VBOOT_CMAC_HSM
  ...  aTestAuthor: Bishoy ADEL
  ...  aReference: CSC_2015_202
  ...  aTestGoal: Checking that if authentication failed of BL 31 for first time for A53 the system should be reseted

  Initialize Communication    a53
  HSM should be authenticated using HSM_CMAC
  Should Be True    authenticated
  #for R5
  Checking hash using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  Should Be True    HSM  shall authenticate the R5 autosar
  #for BL 31
  Checking hash for BL 31 using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for BL 31 of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Not Be True     ${signature_hash}
  #for BL 33
  Checking hash for BL 33 using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for BL 33 of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for Kernel
  Checking hash for Kernel using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for Kernel of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for Linux device tree 
  Checking hash for Linux device tree using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for Linux device tree of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for InitRamFS
  Checking hash for InitRamFS using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for InitRamFS of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  #for Application
  Checking hash for Application using HASH-256 and compare it with the signed hash
  Should Be Equal     ${signed_Hash}    ${calculated_Hash}
  Checking the signature for Application of the hash using the RSA public key stored in the certificate PROD_THUNDERDMSM_VALEO_APPLICATION 
  Should Be True     ${signature_hash}
  Should Be True    the system is reseted
  log the reason of failed
#####################################################################################################################
SwIT_VCore_F6_VBOOT_CMAC_HSM_0010
  [Tags]              MANUAL 
  [Documentation]
  ...  Object Text: Checking that the system should be reseted if the authentication failed of BL 33 for first time for A53
  ...  aTestGroup: F6