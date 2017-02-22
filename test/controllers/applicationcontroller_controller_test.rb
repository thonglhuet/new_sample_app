require 'test_helper'

class ApplicationcontrollerControllerTest < ActionDispatch::IntegrationTest
  test "should get bar" do
    get applicationcontroller_bar_url
    assert_response :success
  end

  test "should get baz" do
    get applicationcontroller_baz_url
    assert_response :success
  end

end
