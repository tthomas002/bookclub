require "application_system_test_case"

class ChaptersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user)
    @admin = users(:admin)
    @book = books(:three_chapters)
  end

  test "user can see list of chapters" do
    sign_in @user
    visit book_chapters_url(@book)
    assert_selector "h2", text: "Chapters"
  end

  test "non-user can't see list of chapters" do
    visit book_chapters_url(@book)
    assert_current_path new_user_session_path
  end

  test "user can navigate back to the books index from chapters index" do
    sign_in @user
    visit book_chapters_url(@book)
    click_on "Books"
    assert_current_path books_path
  end

  test "regular user cant see Edit or Destroy link" do
    sign_in @user
    visit book_chapters_url(@book)
    refute_link "Edit", class: "chapter-edit-link"
    refute_link "Delete"
    refute_button "Save"
  end

  test "adding chapters to a book as admin" do
    sign_in @admin
    visit book_chapters_url(@book)
    fill_in "chapter_title", with: "Adding Chapter"
    click_on "Save"

    assert_text "Chapter successfully created"    
  end

  test "updating a chapter with a name as admin" do
    sign_in @admin
    visit book_chapters_url(@book)
    click_on "Edit", class: "chapter-edit-link", match: :first
    fill_in "Title", with: "Testing Update"
    click_on "Update Chapter"

    assert_text "Chapter was successfully updated"
    assert_text "Testing Update"
  end

  test 'destroying the last chapter as admin' do
    sign_in @admin
    visit book_chapters_url(@book)
    
    page.accept_confirm do
      click_on "Delete"
    end

    assert_text "Chapter was successfully destroyed"
  end
end
