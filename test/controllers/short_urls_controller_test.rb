require "test_helper"

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get encode" do
    get short_urls_encode_url
    assert_response :success
  end

  test "should get decode" do
    get short_urls_decode_url
    assert_response :success
  end
end
