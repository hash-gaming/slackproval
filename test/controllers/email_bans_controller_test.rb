require 'test_helper'

class EmailBansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_ban = email_bans(:one)
  end

  test "should get index" do
    get email_bans_url
    assert_response :success
  end

  test "should get new" do
    get new_email_ban_url
    assert_response :success
  end

  test "should create email_ban" do
    assert_difference('EmailBan.count') do
      post email_bans_url, params: { email_ban: { string: @email_ban.string } }
    end

    assert_redirected_to email_ban_url(EmailBan.last)
  end

  test "should show email_ban" do
    get email_ban_url(@email_ban)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_ban_url(@email_ban)
    assert_response :success
  end

  test "should update email_ban" do
    patch email_ban_url(@email_ban), params: { email_ban: { string: @email_ban.string } }
    assert_redirected_to email_ban_url(@email_ban)
  end

  test "should destroy email_ban" do
    assert_difference('EmailBan.count', -1) do
      delete email_ban_url(@email_ban)
    end

    assert_redirected_to email_bans_url
  end
end
