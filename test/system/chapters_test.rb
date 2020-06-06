require "application_system_test_case"

class ChaptersTest < ApplicationSystemTestCase

  setup do
    visit '/'
    click_on "book-title-link", match: :first
  end

  test "listing chapters in book detail view" do
    assert_selector "h3", text: "Chapters"
  end

  test "adding chapters to a book" do
    book = books(:one)
    click_on "Add Chapter"
    assert_selector "p", text: "Chapter #{book.chapters.count}"    
  end

  test "updating a chapter with a name" do
    click_on "Edit", match: :first
    fill_in "Title", with: "Testing The Book"
    click_on "Update Chapter"

    assert_text "Chapter was successfully updated"
  end

  test 'destroying the last chapter' do
    page.accept_confirm do
      click_on "Delete Chapter"
    end

    assert_text "Chapter was successfully destroyed"
  end
end
