require "test_helper"

class Admin::GenreRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_genre_relations_destroy_url
    assert_response :success
  end
end
