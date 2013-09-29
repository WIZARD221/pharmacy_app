Feature: Shopping

	@javascript
	Scenario: Adding items with different quantities and from different stores
	    Given a user visits the home page
	    When he selects a 30 Day item from a store
	    	And he selects a 90 Day item from a different store
	    Then the items should appear in the shopping cart
	    	