require "application_system_test_case"

class FestivalsTest < ApplicationSystemTestCase
  setup do
    @festival = festivals(:one)
  end

  test "visiting the index" do
    visit festivals_url
    assert_selector "h1", text: "Festivals"
  end

  test "should create festival" do
    visit festivals_url
    click_on "New festival"

    check "Application state" if @festival.application_state
    fill_in "Name", with: @festival.name
    check "State" if @festival.state
    fill_in "User", with: @festival.user_id
    fill_in "Year", with: @festival.year
    click_on "Create Festival"

    assert_text "Festival was successfully created"
    click_on "Back"
  end

  test "should update Festival" do
    visit festival_url(@festival)
    click_on "Edit this festival", match: :first

    check "Application state" if @festival.application_state
    fill_in "Name", with: @festival.name
    check "State" if @festival.state
    fill_in "User", with: @festival.user_id
    fill_in "Year", with: @festival.year
    click_on "Update Festival"

    assert_text "Festival was successfully updated"
    click_on "Back"
  end

  test "should destroy Festival" do
    visit festival_url(@festival)
    click_on "Destroy this festival", match: :first

    assert_text "Festival was successfully destroyed"
  end
end
