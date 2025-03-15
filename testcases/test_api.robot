*** Settings ***
# Resource    ${CURDIR}/../keywords/import.robot
Resource    ../keywords/import.robot

*** Test Cases ***
TC_2.1 Get user infomation and Verify Status
    # Get
    RequestsLibrary.Create Session    get    https://reqres.in/api
    ${response}    GET On Session    get    /users/2
    # Verify Status
    RequestsLibrary.Status Should Be    200    ${response}

TC_2.2 Create User and Verify Data
    # Create
    RequestsLibrary.Create Session    cerate    https://reqres.in/api
    ${data}    BuiltIn.Create Dictionary    name=${TC_2.Create.name}    job=${TC_2.Create.job}
    ${headers}    BuiltIn.Create Dictionary    Content-Type=application/json
    ${response}    RequestsLibrary.POST On Session    cerate    /users    json=${data}    headers=${headers}
    # Verify Status
    RequestsLibrary.Status Should Be    201    ${response}
    # Convert Type
    ${dateCreate}    DateTime.Convert Date    ${response.json()["createdAt"]}    %d-%m-%Y
    ${dateNow}    DateTime.Get Current Date    result_format=%d-%m-%Y
    # Verify Data
    BuiltIn.Should Be Equal    ${data["name"]}    ${response.json()["name"]}
    BuiltIn.Should Be Equal    ${data["job"]}    ${response.json()["job"]}
    BuiltIn.Should Be Equal    ${dateNow}    ${dateCreate}

TC_2.3 Update User and Verify Data
    # Update
    RequestsLibrary.Create Session    update    https://reqres.in/api
    ${data}    BuiltIn.Create Dictionary    name=${TC_2.Update.name}    job=${TC_2.Update.job}
    ${headers}    BuiltIn.Create Dictionary    Content-Type=application/json
    ${response}    RequestsLibrary.PUT On Session    update    /users/2    json=${data}    headers=${headers}
    # Verify Status
    RequestsLibrary.Status Should Be    200    ${response}
    # Convert Type
    ${dateCreate}    DateTime.Convert Date    ${response.json()["updatedAt"]}    %d-%m-%Y
    ${dateNow}    DateTime.Get Current Date    result_format=%d-%m-%Y
    # Verify Data
    BuiltIn.Should Be Equal    ${data["name"]}    ${response.json()["name"]}
    BuiltIn.Should Be Equal    ${data["job"]}    ${response.json()["job"]}
    BuiltIn.Should Be Equal    ${dateNow}    ${dateCreate}

TC_2.4 Delete User and Verify Status
    # Delete
    RequestsLibrary.Create Session    delete    https://reqres.in/api
    ${response}    RequestsLibrary.DELETE On Session    delete    /users/2
    # Verify Status
    RequestsLibrary.Status Should Be    204    ${response}