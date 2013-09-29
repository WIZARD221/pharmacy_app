Feature: Search

	@javascript
	Scenario: Unuccessful search
	    Given a user visits the home page
	    When he searches for non existing information
	    Then he should see no matching results	

	@javascript
	Scenario: Successful search
	    Given a user visits the home page
	    When he searches for existing information
	    Then he should see the matching result