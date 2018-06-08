# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test_user1 = User.create(
  { 
    username: "test_user1", email: "test_user1@gmail.com", 
    password: "test_user1", password_confirmation: "test_user1"
  }
)

test_user2 = User.create(
  { 
    username: "test_user2", email: "test_user2@gmail.com", 
    password: "test_user2", password_confirmation: "test_user2"
  }
)

test_story1 = Story.create(
  {
    title: "Test Story 1", subtitle: "Test Subtitle 1",
    snippet_length: 200, color: "260C4D", dark_theme: false,
    creator_id: test_user1.id
  }
)

test_story2 = Story.create(
  {
    title: "Test Story 2", subtitle: "Test Subtitle 2",
    snippet_length: 200, color: "36181F", dark_theme: true,
    creator_id: test_user2.id
  }
)

test_user1.set_contribution_color(test_story1, "FF0000")
test_user2.set_contribution_color(test_story1, "0000FF")

test_user1.set_contribution_color(test_story2, "FF00FF")
test_user2.set_contribution_color(test_story2, "00FFFF")

test_user1.vote(test_story1, "3")
test_user2.vote(test_story1, "4")

test_user1.vote(test_story2, "1")
test_user2.vote(test_story2, "5")

test_snip1 = test_story1.snippets.build(
  {
    user_id: test_user1.id,
    content: "The first snippet.",
    paragraph_begin: false, paragraph_end: false,
    position: 0
  }
)

test_snip1.save

test_snip2 = test_story1.snippets.create(
  {
    user_id: test_user2.id,
    content: "The second snippet.",
    paragraph_begin: false, paragraph_end: true,
    position: 1
  }
)

test_snip2.save

test_snip3 = test_story2.snippets.create(
  {
    user_id: test_user1.id,
    content: "The first snippet.",
    paragraph_begin: false, paragraph_end: true,
    position: 0
  }
)

test_snip3.save

test_snip4 = test_story2.snippets.create(
  {
    user_id: test_user2.id,
    content: "The second snippet.",
    paragraph_begin: false, paragraph_end: false,
    position: 1
  }
)

test_snip4.save
