require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "content can't be blank" do
    post_without_content = Post.new(chapter: chapters(:book_one_chapter_one), title: "Hello, world")

    post_without_content.save
    
    assert_includes(post_without_content.errors.full_messages, "Content can't be blank")
  end

  test "title can't be blank" do
    post_without_title = Post.new(chapter: chapters(:book_one_chapter_one), content: "Testing")

    post_without_title.save

    assert_includes(post_without_title.errors.full_messages, "Title can't be blank")
  end
end
