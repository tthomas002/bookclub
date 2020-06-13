require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  
  setup do
    @book = books(:one)
    @user = users(:user)
    @admin = users(:admin)
  end

  test "allows a logged in user to visit the root page" do
    sign_in @user
    visit root_path
    assert_selector "h1", text: "Books"
  end

  test "does not allow a user to see the root page if they are not logged in" do
    visit root_url
    assert_current_path new_user_session_path
  end

  test "regular user cannot see Edit, Delete, and New Book links" do
    sign_in @user
    visit root_path
    refute_link "Edit", class: "book-edit-link"
    refute_link "Delete"
    refute_link "New Book"
  end

  test "creating a Book as admin" do
    sign_in @admin
    visit books_url
    click_on "New Book"

    fill_in "Title", with: "Test Title"
    click_on "Create Book"

    assert_text "Book was successfully created"
    assert_text "Test Title"
  end

  test "updating a Book as admin" do
    sign_in @admin
    visit books_url
    click_on "Edit", class: "book-edit-link", match: :first

    fill_in "Title", with: "New Title"
    click_on "Update Book"

    assert_text "Book was successfully updated"
    assert_text "New Title"
  end

  test "destroying a Book as admin" do
    sign_in @admin
    visit books_url
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Book was successfully destroyed"
  end
end
