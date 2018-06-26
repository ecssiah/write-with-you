# JQuery Extensions
1. Move new story functionality to dialog box on user page
2. Move snippet color to story page and async update 
3. Allow editing snippets from story page
4. Add next/prev story buttons to show page 
5. Story prototype with formatting for display (i.e. Title: Subtitle)

# Questions
1. Method for dealing with the snippet position limits?
2. Difference between create and build related to when the new object is placed into the parent's collection. 

# Controllers:
1. PagesController
2. UsersController
3. SessionsController
4. StoriesController
5. SnippetsController

# Models:
1. User
   - username
   - password
   - stories
   - snippets
   - contributions
2. Story
   - snippets
   - creator
   - contributions
   - color
3. Snippet
   - story
   - content
   - paragraph_begin
   - paragraph_end
4. Contribution
   - user
   - story
   - color

# Views:
1. PagesController
   - /
2. UsersController
   - /signup
3. SessionsController
   - /login
3. StoriesController
   - /stories 
   - /stories/new
   - /stories/:id
   - /stories/:id/edit
4. SnippetsController
   - /stories/:id/snippets/new
   - /stories/:id/snippets/:snippet_id
   - /stories/:id/snippets/:snipped_id/edit

# Features:
- Each user has a color that identities their contributions by highlighting the text.
- Users can choose an existing story or author their own story and insert a snippet into the story.
- Some limitations on contributing to a story before other users have contributed.
- Creators can edit stories directly.
- Contributors edit stories through their snippets.
- Users can rate stories. 
- The stories index is ordered by rating by default.


# Deploying to Heroku
1. Migrate app from sqlite3 to postgres
   - Include `gem 'pg'` and remove `gem 'sqlite3'
   - Change information in database.yml to use postgres
   - Migrate database with `heroku run rake db:migrate`
2. Configure your app to serve your static assets
   - Update application.rb with `config.serve_static_assets = true`
   - Update environments/production.rb with `config.serve_static_files = true`
   - Update environments/production.rb with `config.assets.compile = true`
   - Run `bundle exec rake assets:precompile RAILS_ENV=production`
3. Set environment variables with Heroku CLI or dashboard to allow OmniAuth to work
4. Authorize Heroku url as accepted redirect for your OmniAuth provider
