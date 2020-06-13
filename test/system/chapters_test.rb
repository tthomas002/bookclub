require "application_system_test_case"

class ChaptersTest < ApplicationSystemTestCase

  setup do
    visit book_chapters_url(books(:three_chapters))
  end

  test "listing chapters in book detail view" do
    assert_selector "h3", text: "Chapters"
  end

  test "navigating back to the books index" do
    click_on "Books"
    assert_current_path root_path
  end

  test "adding chapters to a book" do
    fill_in "chapter_title", with: "Adding Chapter"
    click_on "Save"

    assert_text "Chapter successfully created"    
  end

  test "updating a chapter with a name" do
    click_on "Edit", match: :first
    fill_in "Title", with: "Testing Update"
    click_on "Update Chapter"

    assert_text "Chapter was successfully updated"
    assert_text "Testing Update"
  end

  test 'destroying the last chapter' do
    page.accept_confirm do
      click_on "Delete"
    end

    assert_text "Chapter was successfully destroyed"
  end
end
