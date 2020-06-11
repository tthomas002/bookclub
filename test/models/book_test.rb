require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "title cant be blank" do
    assert_not Book.new.save
  end
end
