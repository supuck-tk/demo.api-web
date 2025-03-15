*** Settings ***
# Resource    ${CURDIR}/../keywords/import.robot
Resource    ../keywords/import.robot
Suite Teardown    Close Browser

*** Test Cases ***
TC_1.1 Open Browser and Login
    common.Open web browser
    index_page.Input username    ${TC_1.data1.userName}
    index_page.Input password    ${TC_1.data1.password}
    index_page.Click button login

TC_1.2 Add Product to Cart and Verify on Cart
    ${listActive}    index_page.Verify product active    ${TC_1.data2.nameProduct}
    index_page.Click add product to cart    ${listActive}
    index_page.Click button cart
    index_page.Verify product on cart    ${listActive}
    BuiltIn.Set Suite Variable  ${LIST_UPDATE_PRODUCT}    ${listActive}

TC_1.3 Remove Product on Cart and Verify Remove
    index_page.Click button remove product    ${TC_1.data3.removeProduct}
    ${listCart}    index_page.Verify product on cart    ${LIST_UPDATE_PRODUCT}
    BuiltIn.Set Suite Variable  ${LIST_UPDATE_CART}    ${listCart}

TC_1.4 Checkout Order and Fill in Information
    index_page.Click button checkout
    index_page.Input first name    ${TC_1.data4.firstName}
    index_page.Input last name    ${TC_1.data4.lastName}
    index_page.Input zip code    ${TC_1.data4.zipCode}
    index_page.Click button continue

TC_1.5 Calculate Total and Verify Total
    ${total_cal}    index_page.Calculate price    ${LIST_UPDATE_CART}
    index_page.Verify price tatol    ${total_cal}

TC_1.6 Submit Order and Verify Order Success
    index_page.Click button finish
    index_page.Verify checkout success    ${TC_1.data6.orderSuccess}