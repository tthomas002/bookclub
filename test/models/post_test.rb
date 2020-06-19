require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "content can't be blank" do
    post_without_content = Post.new(chapter: chapters(:book_one_chapter_one), title: "Hello, world", user: users(:user))

    post_without_content.save
    
    assert_includes(post_without_content.errors.full_messages, "Content can't be blank")
  end

  test "title can't be blank" do
    post_without_title = Post.new(chapter: chapters(:book_one_chapter_one), content: "Testing", user: users(:user))

    post_without_title.save

    assert_includes(post_without_title.errors.full_messages, "Title can't be blank")
  end

  test "post must have user" do
    post_without_user = Post.new(title: "No User", chapter: chapters(:book_one_chapter_one), content: "Testing")

    assert_not post_without_user.save
  end
end
