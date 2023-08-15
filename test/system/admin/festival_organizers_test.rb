require "application_system_test_case"

class Admin::FestivalOrganizersTest < ApplicationSystemTestCase
  setup do
    @admin_festival_organizer = admin_festival_organizers(:one)
  end

  test "visiting the index" do
    visit admin_festival_organizers_url
    assert_selector "h1", text: "Festival organizers"
  end

  test "should create festival organizer" do
    visit admin_festival_organizers_url
    click_on "New festival organizer"

    fill_in "Festival", with: @admin_festival_organizer.festival_id
    fill_in "User", with: @admin_festival_organizer.user_id
    click_on "Create Festival organizer"

    assert_text "Festival organizer was successfully created"
    click_on "Back"
  end

  test "should update Festival organizer" do
    visit admin_festival_organizer_url(@admin_festival_organizer)
    click_on "Edit this festival organizer", match: :first

    fill_in "Festival", with: @admin_festival_organizer.festival_id
    fill_in "User", with: @admin_festival_organizer.user_id
    click_on "Update Festival organizer"

    assert_text "Festival organizer was successfully updated"
    click_on "Back"
  end

  test "should destroy Festival organizer" do
    visit admin_festival_organizer_url(@admin_festival_organizer)
    click_on "Destroy this festival organizer", match: :first

    assert_text "Festival organizer was successfully destroyed"
  end
end
