require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "content can't be blank" do
    post_without_content = Post.new(chapter: chapters(:book_one_chapter_one))

    assert_not post_without_content.save
  end
end
