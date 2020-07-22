require "application_system_test_case"

class EnrollementsTest < ApplicationSystemTestCase
  setup do
    @enrollement = enrollements(:one)
  end

  test "visiting the index" do
    visit enrollements_url
    assert_selector "h1", text: "Enrollements"
  end

  test "creating a Enrollement" do
    visit enrollements_url
    click_on "New Enrollement"

    fill_in "Course", with: @enrollement.course_id
    fill_in "Price", with: @enrollement.price
    fill_in "Rating", with: @enrollement.rating
    fill_in "Review", with: @enrollement.review
    fill_in "User", with: @enrollement.user_id
    click_on "Create Enrollement"

    assert_text "Enrollement was successfully created"
    click_on "Back"
  end

  test "updating a Enrollement" do
    visit enrollements_url
    click_on "Edit", match: :first

    fill_in "Course", with: @enrollement.course_id
    fill_in "Price", with: @enrollement.price
    fill_in "Rating", with: @enrollement.rating
    fill_in "Review", with: @enrollement.review
    fill_in "User", with: @enrollement.user_id
    click_on "Update Enrollement"

    assert_text "Enrollement was successfully updated"
    click_on "Back"
  end

  test "destroying a Enrollement" do
    visit enrollements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Enrollement was successfully destroyed"
  end
end
