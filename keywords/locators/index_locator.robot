*** Variables ***
# Login Page
${userName.input}    id=user-name
${passWord.inpput}    id=password
${login.btn}    id=login-button
# Navbar
${iconCart.btn}    id=shopping_cart_container
${badgeCart.txt}    //span[@class="shopping_cart_badge"]
# Home Page
${itemName.txt}    //div[@class="inventory_item_name " and (.="+ PRODUCT +")]
${itemPrice.txt}    //div[@class="inventory_item_name " and (.="+ PRODUCT +")]/ancestor::div[@class="inventory_item_description"]//div[@class="inventory_item_price"]
${addCart.btn}    //div[@class="inventory_item_name " and (.="+ PRODUCT +")]/ancestor::div[@class="inventory_item_description"]//button
# Cart Detail
${itemName_onCart.txt}    //div[@class="inventory_item_name" and (.="+ PRODUCT +")]
${itemPrice_onCart.txt}    //div[@class="inventory_item_name" and (.="+ PRODUCT +")]/parent::a/following-sibling::div//div[@class="inventory_item_price"]
${removeCart.btn}    //div[@class="inventory_item_name" and (.="+ PRODUCT +")]/parent::a/following-sibling::div//button
${checkOut.btn}    id=checkout
# Checkout Information
${firstName.input}    id=first-name
${lastName.input}    id=last-name
${zipCode.input}    id=postal-code
${continue.btn}    id=continue
# Checkout Overview
${subTotal.txt}    //div[@class="summary_subtotal_label"]
${tax.txt}    //div[@class="summary_tax_label"]
${total.txt}    //div[@class="summary_total_label"]
${submit.btn}    id=finish
${complete.txt}    //div[@id="checkout_complete_container"]//h2
# Product list : Suite Variable
${LIST_UPDATE_PRODUCT}
${LIST_UPDATE_CART}