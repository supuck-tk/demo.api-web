*** Settings ***
# Resource    ${CURDIR}/import.robot
Resource    ../keywords/import.robot

*** Keywords ***
Open web browser
    SeleniumLibrary.Open Browser    ${websiet.url}    ${websiet.browser}
    SeleniumLibrary.Set Window Size   1440    900

Click element when ready
    [Arguments]    ${locator}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${time}
    SeleniumLibrary.Click Element    ${locator}

Clear element text
    [Arguments]    ${locator}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${time}
    SeleniumLibrary.Clear Element Text    ${locator}

Element visible when ready
    [Arguments]    ${locator}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${time}
    SeleniumLibrary.Element Should Be Visible    ${locator}

Element not visible when ready
    [Arguments]    ${locator}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Not Visible    ${locator}    ${time}
    SeleniumLibrary.Element Should Not Be Visible    ${locator}

Verify element content text
    [Arguments]    ${contentText}    ${locator}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${time}
    ${elementText}    SeleniumLibrary.Get Text    ${locator}
    BuiltIn.Should Be Equal    ${contentText}    ${elementText}

Input text when ready
    [Arguments]    ${locator}    ${textInput}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${time}
    SeleniumLibrary.Input Text    ${locator}    ${textInput}

Get text when ready
    [Arguments]    ${locator}    ${time}=${waitingTime.short}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${time}
    ${getText}    SeleniumLibrary.Get Text    ${locator}
    RETURN    ${getText}