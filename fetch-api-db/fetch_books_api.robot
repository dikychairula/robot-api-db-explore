*** Settings ***
Library    RequestsLibrary
Library    DatabaseLibrary
Library    Collections

*** Variables ***
${API_URL}       http://simple-books-api.glitch.me/books
${DB_HOST}       localhost
${DB_USER}       root
${DB_PASSWORD}   
${DB_NAME}       db_book_api
${DB_PORT}       3306

*** Test Cases ***
Fetch and Insert Books
    [Documentation]    Ambil data buku dari API lalu simpan ke database lokal
    ${response} =    GET    ${API_URL}  
    Should Be Equal As Numbers    ${response.status_code}    200  
    ${books} =    Set Variable    ${response.json()}

    Connect To Database    pymysql    
    ...    ${DB_NAME}
    ...    ${DB_USER}
    ...    ${DB_PASSWORD}
    ...    ${DB_HOST}
    ...    ${DB_PORT}

    FOR    ${book}    IN    @{books}
        ${id} =    Set Variable    ${book["id"]}
        ${name} =    Set Variable    ${book["name"]}
        ${type} =    Set Variable    ${book["type"]}
        ${available} =    Set Variable    ${book["available"]}

        Execute SQL String
        ...    INSERT INTO books VALUES ('${id}', '${name}', '${type}', ${available})
    END

    Disconnect From Database
    Log To Console    ${books}
    Log To Console    "Data buku berhasil disimpan ke database!"