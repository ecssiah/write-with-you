# Controllers:
1. UsersController
2. StoriesController
3. SnippetsController

# Models:
1. User
    1. username
    2. email
    3. password
    4. stories_created
    5. stories_authored
    6. snippets
2. Story
    1. snippets
    2. creator
    3. authors
    4. created
    5. last_updated
3. Snippet
    1. content
    2. story

# Views:
1. users/login
2. users/signup
3. stories/index
4. stories/new
5. stories/:id
6. stories/:id/:snippet_id
7. stories/:id/:snipped_id/new
8. stories/:id/:snipped_id/edit

Features:
1. Users can choose an existing story, and insert their own writing into the story.
    1. Some limitations on the total content each user can add to a story before other users are given a chance.
2. Each user has a color that identities their additions by highlighting the text.
3. Edits to a story always occur through snippets. Direct editing of a story is restricted.
4. Users can rate stories. The main listing of stories ranks them by rating.



