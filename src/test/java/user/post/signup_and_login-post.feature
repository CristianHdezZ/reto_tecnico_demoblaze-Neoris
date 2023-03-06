@Test_APIS
Feature: Post, the user signup and login in page demoblaze

  Background:
    * url 'https://api.demoblaze.com'
    * def bodyRequestLogin = read ("request-login.json")
    * request bodyRequestLogin
    * def expectedOutput_incorrect_pass = read("response_login_incorrect_pass.json")
    * def expectedOutput_incorrect_username = read("response_login_incorrect_username.json")
    * def expectedOutput_signup = read("response_signup_failed.json")
    * def fakeUsername =  new faker()
    * def fName = fakeUsername.name().firstName()
    * def lName = fakeUsername.name().lastName()
    * def fUserName = fName+lName+"TestQA"


  @Crear_un_nuevo_usuario_en_signup
  Scenario Outline: signup user successful
    Given path "/signup"
    And request { "username": "#(fUserName)", "password": "#(password)" }
    When method post
    Then status 200
    And match response != expectedOutput_signup
    And print response

    Examples:
      | password  |
      |12345678|


  @Intentar_crear_un_usuario_ya_existente
  Scenario Outline: signup user failed
    Given path "/signup"
    When method post
    Then status 200
    And match response == expectedOutput_signup
    And print response

    Examples:
      | username | password  |
      | Chernfzab23 |12345678|



@Usuario_y_password_correcto_en_login
  Scenario Outline: login user successful
    Given path "/login"
    When method post
    Then status 200
    And match response contains "Auth_token:"
    And match $ contains "Auth_token:"
    And print response

    Examples:
      | username     | password  |
      | cristianhz90 |MTIzNDU2Nzg=|


  @password_incorrecto_en_login
  Scenario Outline: login failed to password
    Given path "/login"
    When method post
    Then status 200
    And match response == expectedOutput_incorrect_pass
    And match $ == expectedOutput_incorrect_pass
    And print response

    Examples:
      | username     | password  |
      | cristianhz90 |MTIzNDU2Nzgg=|


  @Usuario_incorrecto_en_login
  Scenario Outline: login failed to username
    Given path "/login"
    When method post
    Then status 200
    And match response == expectedOutput_incorrect_username
    And match $ == expectedOutput_incorrect_username
    And print response

    Examples:
      | username     | password  |
      | cristianhz977770 |MTIzNDU2Nzg=|
