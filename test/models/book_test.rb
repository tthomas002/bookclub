require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "must have title" do
    assert_not Book.new.save
  end
end
