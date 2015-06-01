
@snippets

Feature: Manage code snippets

  In order to execute commands remotelly
  As a web site visitor
  I want to be able to manage snippets

  Background:
    Given there are users:
      | username  | email             | password  | password_confirmation |
      | User_1    | user_1@email.com  | user1pass | user1pass             |
      | User_2    | user_2@email.com  | user2pass | user2pass             |
    Given there are snippets:
      | name      | content           |
      | Snippet_1 | echo "Snippet_1"  |
      | Snippet_2 | echo "Snippet_2"  |

  Scenario: Snippets are listed on home page
    When I visit the home page
    Then I should see existing snippets 
    
  Scenario: Create new snippet
    Given I am logged in
    When I create new snippet
    Then I should see it on snippets list
     
  Scenario: Edit snippet
    Given I am logged in
    When I edit snippet
    Then I should be able to change the snippet
    And changes should be visible on snippets list
    
  Scenario: Delete snippet
    Given I am logged in
    When I delete snippet
    Then I should not see it on snippets list

  Scenario Outline: Actions are available only to logged in users
    Given I am not logged in
    When I execute action <action>
    Then I should be redirected to Log In page
      Examples:
       | action           | 
       | "Create Snippet" | 
       | "Remove"         | 
       | "Edit"           | 
 
  Scenario Outline: Execute snippet
    Given I am logged in
    When I execute snippet <name> with <content>
    Then I should see <output>
      Examples:
       | name                 | content                           | output          |
       | "Print message"      | "echo Hello world"                | "Hello world"   |
       | "Create file"        | "echo file content \> file\.txt"  | ""              |
       | "Show file content"  | "cat file.txt"                    | "file content"  |
