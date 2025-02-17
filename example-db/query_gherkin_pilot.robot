*** Settings ***
Library    DatabaseLibrary

*** Variables *** 

*** Test Cases ***
Open DB GherkinPilot
    Connect To Gherkin API DB
    DB validation successfuly registered

*** Keywords ***
Connect To Gherkin API DB     #Connection for database
    Connect To Database
    ...    psycopg2
    ...    db_name=gherkin_api_db
    ...    db_user=gherkin
    ...    db_password=6q3Jpx75N5SyuQgc5
    ...    db_host=192.168.0.105
    ...    db_port=5416

DB validation successfuly registered    #Query Database
    ${sql}=    Catenate    SELECT email FROM users WHERE email = 'titoqa@yopmail.com'
    Check Row Count    ${sql}   ==    1
    Disconnect From Database