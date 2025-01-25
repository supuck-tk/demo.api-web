*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    DateTime
Library    Collections
Library    String
#features
#locators
Resource    ${CURDIR}/locators/index_locator.robot
#pages
Resource    ${CURDIR}/common.robot
Resource    ${CURDIR}/pages/index_page.robot
#testdata
Variables    ${CURDIR}/../resources/setting/setting.yaml
Variables    ${CURDIR}/../resources/testdata/data.yaml