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
   - user
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
- Each user has a color that identities their contributions by highlighting the text.
- Users can choose an existing story or author their own story and insert a snippet into the story.
- Some limitations on contributing to a story before other users have contributed.
- Creators can edit stories directly.
- Contributors edit stories through their snippets.
- Users can rate stories. 
- The stories index is ordered by rating by default.



