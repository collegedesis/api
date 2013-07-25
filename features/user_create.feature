Feature: Creating Users
  @javascript
  Scenario: creating a user
    When I go to the join page
    And sign up as a new user
    Then there should be a new user in the database
    And I should be redirected to the login page