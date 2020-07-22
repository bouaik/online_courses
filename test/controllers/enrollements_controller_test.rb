require 'test_helper'

class EnrollementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enrollement = enrollements(:one)
  end

  test "should get index" do
    get enrollements_url
    assert_response :success
  end

  test "should get new" do
    get new_enrollement_url
    assert_response :success
  end

  test "should create enrollement" do
    assert_difference('Enrollement.count') do
      post enrollements_url, params: { enrollement: { course_id: @enrollement.course_id, price: @enrollement.price, rating: @enrollement.rating, review: @enrollement.review, user_id: @enrollement.user_id } }
    end

    assert_redirected_to enrollement_url(Enrollement.last)
  end

  test "should show enrollement" do
    get enrollement_url(@enrollement)
    assert_response :success
  end

  test "should get edit" do
    get edit_enrollement_url(@enrollement)
    assert_response :success
  end

  test "should update enrollement" do
    patch enrollement_url(@enrollement), params: { enrollement: { course_id: @enrollement.course_id, price: @enrollement.price, rating: @enrollement.rating, review: @enrollement.review, user_id: @enrollement.user_id } }
    assert_redirected_to enrollement_url(@enrollement)
  end

  test "should destroy enrollement" do
    assert_difference('Enrollement.count', -1) do
      delete enrollement_url(@enrollement)
    end

    assert_redirected_to enrollements_url
  end
end
