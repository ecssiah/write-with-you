# Controllers:
1. PagesController
1. UsersController
1. StoriesController
1. SnippetsController

# Models:
1. User
    2. username
    2. email
    2. password
    2. stories_created
    2. stories_authored
    2. snippets
1. Story
    2. snippets
    2. creator
    2. authors
    2. created
    2. last_updated
1. Snippet
    2. content
    2. story
1. Contribution
    2. author
    2. story

# Views:
1. users/login
1. users/signup
1. stories/index
1. stories/new
1. stories/:id
1. stories/:id/:snippet_id
1. stories/:id/:snipped_id/new
1. stories/:id/:snipped_id/edit

Features:
1. Users can choose an existing story, and insert their own writing into the story.
    2. Some limitations on the total content each user can add to a story before other users are given a chance.
1. Each user has a color that identities their additions by highlighting the text.
1. Edits to a story always occur through snippets. Direct editing of a story is restricted.
1. Users can rate stories. The main listing of stories ranks them by rating.



