require 'test_helper'

class IpBansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ip_ban = ip_bans(:one)
  end

  test "should get index" do
    get ip_bans_url
    assert_response :success
  end

  test "should get new" do
    get new_ip_ban_url
    assert_response :success
  end

  test "should create ip_ban" do
    assert_difference('IpBan.count') do
      post ip_bans_url, params: { ip_ban: { string: @ip_ban.string } }
    end

    assert_redirected_to ip_ban_url(IpBan.last)
  end

  test "should show ip_ban" do
    get ip_ban_url(@ip_ban)
    assert_response :success
  end

  test "should get edit" do
    get edit_ip_ban_url(@ip_ban)
    assert_response :success
  end

  test "should update ip_ban" do
    patch ip_ban_url(@ip_ban), params: { ip_ban: { string: @ip_ban.string } }
    assert_redirected_to ip_ban_url(@ip_ban)
  end

  test "should destroy ip_ban" do
    assert_difference('IpBan.count', -1) do
      delete ip_ban_url(@ip_ban)
    end

    assert_redirected_to ip_bans_url
  end
end
