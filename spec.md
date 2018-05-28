# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 
  * User has_many Contributions
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
  * Contribution belongs_to Story
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
  * User has_many Stories through Contributions
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
  * contribution.vote
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  * Story, Snippet, User
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  * Contribution.update_rankings URL: /stories, The stories index is ordered by rank
- [x] Include signup (how e.g. Devise)
  * Custom signup using validation macros and a UsersController
- [x] Include login (how e.g. Devise)
  * Custom login using validations macros and brcrypt and a SessionsController
- [x] Include logout (how e.g. Devise)
  * Custom logout using a destroy route on SessionsController
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  * OmniAuth Google authentication
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  * stories/2/snippets/11/edit, editing and showing are merged into same route 
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
  * stories/2/snippets/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
  * stories/new    

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
