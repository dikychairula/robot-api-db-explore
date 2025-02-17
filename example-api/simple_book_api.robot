*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${baseURL}    http://simple-books-api.glitch.me
${bookType}    fiction   

*** Test Cases ***
Get list book with type fiction
    Create Session    mysession    ${baseURL}
    ${response}=    Get On Session    mysession    /books  params=type=fiction
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    fiction

    # Status Should Be    200    ${response}
    # Log To Console    ${response.status_code}
    # Log To Console    ${response.json()}
    # Log To Console    ${response.headers}

*** Test Cases ***
Get Single Book by Id
    Create Session    mysession    ${baseURL}
    ${response}=    Get On Session    mysession    /books/2
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    2

    Log To Console    ${response.status_code}
    Log To Console    ${body}
    Log To Console    ${response.headers}

Post Register
    Create Session    mysession    ${baseURL}
    ${data}=    Create Dictionary    clientName=willydebeast    clientEmail=wilidebiest@gmail.com
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    Post On Session    mysession    /api-clients/    json=${data}    headers=${headers}

    # Validasi Status Code created
    Should Be Equal As Strings    ${response.status_code}    201
    # Ambil Body Response Token
    ${body}=    Set Variable    ${response.json()}
    # validasi token tidak kosong
    Should Not Be Empty    ${body}

    # Log Output
    Log To Console    ${response.status_code}
    Log To Console    ${body}
    Log To Console    ${response.headers}
