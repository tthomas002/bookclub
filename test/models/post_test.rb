require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "content can't be blank" do
    post_without_content = Post.new(chapter: chapters(:book_one_chapter_one))

    post_without_content.save
    
    assert_includes(post_without_content.errors.full_messages, "Content can't be blank")
  end
end
