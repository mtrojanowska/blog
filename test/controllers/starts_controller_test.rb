require 'test_helper'

class StartsControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get starts_start_url
    assert_response :success
  end

end
