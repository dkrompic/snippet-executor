
@user_management

Feature: Authenticate user
  In order to get access to access snippet actions
  As a web site visitor
  I should be able to register and log in/out

  Scenario: Register
    Given I am new user
    When I register
    Then I should be logged in

  Scenario: Log in/out
    Given I am registered
    When I log in
    Then I should see the log in confirmation
    When I log out
    Then I should see the log out confirmation
