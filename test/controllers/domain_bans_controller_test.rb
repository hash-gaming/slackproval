require 'test_helper'

class DomainBansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @domain_ban = domain_bans(:one)
  end

  test "should get index" do
    get domain_bans_url
    assert_response :success
  end

  test "should get new" do
    get new_domain_ban_url
    assert_response :success
  end

  test "should create domain_ban" do
    assert_difference('DomainBan.count') do
      post domain_bans_url, params: { domain_ban: { string: @domain_ban.string } }
    end

    assert_redirected_to domain_ban_url(DomainBan.last)
  end

  test "should show domain_ban" do
    get domain_ban_url(@domain_ban)
    assert_response :success
  end

  test "should get edit" do
    get edit_domain_ban_url(@domain_ban)
    assert_response :success
  end

  test "should update domain_ban" do
    patch domain_ban_url(@domain_ban), params: { domain_ban: { string: @domain_ban.string } }
    assert_redirected_to domain_ban_url(@domain_ban)
  end

  test "should destroy domain_ban" do
    assert_difference('DomainBan.count', -1) do
      delete domain_ban_url(@domain_ban)
    end

    assert_redirected_to domain_bans_url
  end
end
