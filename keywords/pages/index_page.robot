*** Settings ***
Resource    ${CURDIR}/../import.robot

*** Keywords ***
# Login Page
Input username
    [Arguments]    ${user}
    common.Input text when ready    ${userName.input}    ${user}

Input password
    [Arguments]    ${password}
    common.Input text when ready    ${passWord.inpput}    ${password}

Click button login
    common.Click element when ready    ${login.btn}

# Home Page
Verify product active
    [Arguments]    ${nameProduct}
    ${renge}    BuiltIn.Get Length    ${nameProduct}
    ${productList_active}    BuiltIn.Create List
    FOR  ${index}  IN RANGE  ${renge}
        ${activeProduct}    String.Replace String    ${itemName.txt}    + PRODUCT +    ${nameProduct[${index}]}
        ${status_activeProduct}    BuiltIn.Run Keyword And Return Status    common.Element visible when ready    ${activeProduct}
        IF  "${status_activeProduct}"=="True"
            Collections.Append To List    ${productList_active}    ${nameProduct[${index}]}
        ELSE
            Log    "Product Not Found - ${nameProduct[${index}]}"    WARN
        END
    END
    RETURN    ${productList_active}
    
Click add product to cart
    [Arguments]    ${nameProduct}
    ${renge}    BuiltIn.Get Length    ${nameProduct}
    FOR  ${index}  IN RANGE  ${renge}
        ${addProduct}    String.Replace String    ${addCart.btn}    + PRODUCT +    ${nameProduct[${index}]}
        SeleniumLibrary.Scroll Element Into View    ${addProduct}
        common.Click element when ready    ${addProduct}
    END

Click button cart
    common.Click element when ready    ${iconCart.btn}

# Cart Deatil
Verify product on cart
    [Arguments]    ${nameProduct}
    ${renge}    BuiltIn.Get Length    ${nameProduct}
    ${productList_cart}    BuiltIn.Create List
    FOR  ${index}  IN RANGE  ${renge}
        ${productList}    String.Replace String    ${itemName_onCart.txt}    + PRODUCT +    ${nameProduct[${index}]}
        ${status_productList}    BuiltIn.Run Keyword And Return Status    common.Element visible when ready    ${productList}
        IF  "${status_productList}"=="True"
            ${productCart}    common.Get text when ready    ${productList}
            BuiltIn.Should Be Equal    ${productCart}    ${nameProduct[${index}]}
            Collections.Append To List    ${productList_cart}    ${nameProduct[${index}]}
        ELSE
            Log    "Products May Be Removed From Cart - ${nameProduct[${index}]}"
        END
    END
    RETURN    ${productList_cart}

Click button remove product
    [Arguments]    ${removeProduct}
    ${rengeRemove}    BuiltIn.Get Length    ${removeProduct}
    FOR  ${index}  IN RANGE  ${rengeRemove}
        ${remove}    String.Replace String    ${removeCart.btn}    + PRODUCT +    ${removeProduct[${index}]}
        SeleniumLibrary.Scroll Element Into View    ${remove}
        common.Click element when ready    ${remove}
    END

Click button continue
    common.Click element when ready    ${continue.btn}

# Checkout Information
Input first name
    [Arguments]    ${firstName}
    common.Input text when ready    ${firstName.input}    ${firstName}

Input last name
    [Arguments]    ${lastName}
    common.Input text when ready    ${lastName.input}    ${lastName}

Input zip code
    [Arguments]    ${zipCode}
    common.Input text when ready    ${zipCode.input}    ${zipCode}

Click button checkout
    common.Click element when ready    ${checkOut.btn}

# Checkout Overview
Calculate price
    [Arguments]    ${orderList}
    ${range}    BuiltIn.Get Length    ${orderList}
    ${price_list}    BuiltIn.Create List
    FOR    ${index}    IN RANGE    ${range}
        ${price}    String.Replace String    ${itemPrice_onCart.txt}    + PRODUCT +    ${orderList[${index}]}
        ${priceCurrent}    common.Get text when ready    ${price}
        ${priceList_clean}    String.Remove String    ${priceCurrent}    $
        ${priceList_num}    BuiltIn.Convert To Number    ${priceList_clean}
        Collections.Append To List    ${price_list}    ${priceList_num}
    END
    ${total_price.num}    BuiltIn.Set Variable    0
    FOR     ${index}    IN RANGE    ${range}
        ${total_price.num}    BuiltIn.Evaluate    ${total_price.num}+${price_list[${index}]}
    END
    RETURN    ${total_price.num}

Verify price tatol
    [Arguments]    ${totalCalculate}
    # Calculate Tax and Total Price
    ${tax_cal}    BuiltIn.Set Variable    0
    ${total_cal}    BuiltIn.Set Variable    0
    ${tax_cal}    BuiltIn.Evaluate    round(((${totalCalculate}*1.08)-${totalCalculate})+0.005, 2)
    ${total_cal}    BuiltIn.Evaluate    round((${totalCalculate}*1.08)+0.005, 2)
    # Get Values Price Expect
    ${subTotal_expect}    common.Get text when ready    ${subTotal.txt}
    ${tax_expect}    common.Get text when ready    ${tax.txt}
    ${total_expect}    common.Get text when ready    ${total.txt}
    # Split Number Only : List
    ${subTotal_verify}    String.Get Regexp Matches    ${subTotal_expect}    \\d+\\.\\d+
    ${tax_verify}    String.Get Regexp Matches    ${tax_expect}    \\d+\\.\\d+
    ${total_verify}    String.Get Regexp Matches    ${total_expect}    \\d+\\.\\d+
    # Convert Type Data
    ${subTotal_verify_num}    BuiltIn.Convert To Number    ${subTotal_verify[0]}
    ${tax_verify_num}    BuiltIn.Convert To Number    ${tax_verify[0]}
    ${total_verify_num}    BuiltIn.Convert To Number    ${total_verify[0]}
    # Compare Values
    BuiltIn.Should Be Equal    ${subTotal_verify_num}    ${totalCalculate}
    BuiltIn.Should Be Equal    ${tax_verify_num}    ${tax_cal}
    BuiltIn.Should Be Equal    ${total_verify_num}    ${total_cal}

Click button finish
    common.Click element when ready    ${submit.btn}

Verify checkout success
    [Arguments]    ${msg}
    ${orderSuccess}    common.Get text when ready    ${complete.txt}
    BuiltIn.Should Be Equal    ${orderSuccess}    ${msg}
