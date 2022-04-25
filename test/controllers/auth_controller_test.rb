require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @user = create(:user)
  # end
  
  test "the truth" do
    user = create(:user1)
    assert true
  end
end
