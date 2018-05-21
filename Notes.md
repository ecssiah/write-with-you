# Controllers:
1. PagesController
1. UsersController
1. SessionsController
1. StoriesController
1. SnippetsController

# Models:
1. User
   - username
   - email
   - password
   - stories_created
   - stories_authored
   - snippets
2. Story
   - snippets
   - creator
   - authors
   - created
   - last_updated
3. Snippet
   - content
   - story
4. Contribution
   - author
   - story

# Views:
1. Pages
   - /
2. Users
   - /signup
3. Sessions
   - /login
3. Stories
   - /stories 
   - /stories/new
   - /stories/:id
   - /stories/:id/edit
4. Snippets
   - /stories/:id/snippets/new
   - /stories/:id/snippets/:snippet_id
   - /stories/:id/snippets/:snipped_id/edit

# Features:
1. Users can choose an existing story, and insert their own writing into the story.
   - Some limitations on the total content each user can add to a story before other users are given a chance.
2. Each user has a color that identities their additions by highlighting the text.
3. Edits to a story always occur through snippets. Direct editing of a story is restricted.
4. Users can rate stories. The main listing of stories ranks them by rating.



