require "test_helper"

class Admin::FestivalOrganizersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_festival_organizer = admin_festival_organizers(:one)
  end

  test "should get index" do
    get admin_festival_organizers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_festival_organizer_url
    assert_response :success
  end

  test "should create admin_festival_organizer" do
    assert_difference("Admin::FestivalOrganizer.count") do
      post admin_festival_organizers_url, params: { admin_festival_organizer: { festival_id: @admin_festival_organizer.festival_id, user_id: @admin_festival_organizer.user_id } }
    end

    assert_redirected_to admin_festival_organizer_url(Admin::FestivalOrganizer.last)
  end

  test "should show admin_festival_organizer" do
    get admin_festival_organizer_url(@admin_festival_organizer)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_festival_organizer_url(@admin_festival_organizer)
    assert_response :success
  end

  test "should update admin_festival_organizer" do
    patch admin_festival_organizer_url(@admin_festival_organizer), params: { admin_festival_organizer: { festival_id: @admin_festival_organizer.festival_id, user_id: @admin_festival_organizer.user_id } }
    assert_redirected_to admin_festival_organizer_url(@admin_festival_organizer)
  end

  test "should destroy admin_festival_organizer" do
    assert_difference("Admin::FestivalOrganizer.count", -1) do
      delete admin_festival_organizer_url(@admin_festival_organizer)
    end

    assert_redirected_to admin_festival_organizers_url
  end
end
