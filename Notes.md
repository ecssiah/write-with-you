# Controllers:
1. PagesController
2. UsersController
3. SessionsController
4. StoriesController
5. SnippetsController

# Models:
1. User
   - username
   - email
   - password
   - stories
   - contributions
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
- Each user has a color that identities their additions by highlighting the text.
- Users can choose an existing story, and insert their own writing into the story.
- Some limitations on the total content each user can add to a story before other users are given a chance.
- Edits to a story always occur through snippets. Direct editing of a story is restricted.
- Users can rate stories. The main listing of stories ranks them by rating.



