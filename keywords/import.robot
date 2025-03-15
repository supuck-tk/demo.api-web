*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    DateTime
Library    Collections
Library    String
#features
#locators
# Resource    ${CURDIR}/locators/index_locator.robot
Resource    ../keywords/locators/index_locator.robot
#pages
# Resource    ${CURDIR}/common.robot
# Resource    ${CURDIR}/pages/index_page.robot
Resource    ../keywords/common.robot
Resource    ../keywords/pages/index_page.robot
#testdata
# Variables    ${CURDIR}/../resources/setting/setting.yml
# Variables    ${CURDIR}/../resources/testdata/data.yml
Variables    ../resources/setting/setting.yml
Variables    ../resources/testdata/data.yml