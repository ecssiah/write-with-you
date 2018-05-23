require 'test_helper'

class ContributionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get contributions_show_url
    assert_response :success
  end

  test "should get new" do
    get contributions_new_url
    assert_response :success
  end

  test "should get create" do
    get contributions_create_url
    assert_response :success
  end

  test "should get edit" do
    get contributions_edit_url
    assert_response :success
  end

  test "should get update" do
    get contributions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get contributions_destroy_url
    assert_response :success
  end

end
