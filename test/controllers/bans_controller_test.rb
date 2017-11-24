require 'test_helper'

class BansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ban = bans(:one)
  end

  test "should get index" do
    get bans_url
    assert_response :success
  end

  test "should get new" do
    get new_ban_url
    assert_response :success
  end

  test "should create ban" do
    assert_difference('Ban.count') do
      post bans_url, params: { ban: { ban: @ban.ban, ban_type: @ban.ban_type } }
    end

    assert_redirected_to ban_url(Ban.last)
  end

  test "should show ban" do
    get ban_url(@ban)
    assert_response :success
  end

  test "should get edit" do
    get edit_ban_url(@ban)
    assert_response :success
  end

  test "should update ban" do
    patch ban_url(@ban), params: { ban: { ban: @ban.ban, ban_type: @ban.ban_type } }
    assert_redirected_to ban_url(@ban)
  end

  test "should destroy ban" do
    assert_difference('Ban.count', -1) do
      delete ban_url(@ban)
    end

    assert_redirected_to bans_url
  end
end
