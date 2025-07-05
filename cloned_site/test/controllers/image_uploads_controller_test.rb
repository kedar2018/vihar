require "test_helper"

class ImageUploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get image_uploads_new_url
    assert_response :success
  end

  test "should get create" do
    get image_uploads_create_url
    assert_response :success
  end
end
