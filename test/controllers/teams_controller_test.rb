require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  context "unauthenticated user" do
    setup do 
      @token = 'falsetoken'
    end

    should "not create team" do
      post api_v1_teams_path, params:{:name => "New Team", :description => "Desc"}, headers: {:authorization => @token}
      assert_response :unauthorized
    end

    should "not read teams" do
      get api_v1_teams_path, headers: {:authorization => @token}
      assert_response :unauthorized
    end

    should "not update a team" do
      team = teams(:team1)
      patch api_v1_team_path(team), params:{:description => 'Updated Description'}, headers: {:authorization => @token}
      assert_response :unauthorized
      put api_v1_team_path(team), params:{name:'N', :description => 'U'}, headers: {:authorization => @token}
      assert_response :unauthorized
    end

    should "not delete a team" do
      team = teams(:team1)
      teams_count = Team.all.size
      delete api_v1_team_path(team), headers: {:authorization => @token}
      assert_response :unauthorized
      assert_equal teams_count, Team.all.size
    end
  end
  
  context "authenticated user" do
    setup do
      @user = users(:user1)
      @token = login_and_extract_token @user.email, '123456'
    end

    should "be able to create team" do
      post api_v1_teams_path, params:{:name => "New Team", :description => "Desc"}, headers: {:authorization => @token}
      assert_response :ok
      json = JSON.parse(response.body)
      assert json['id'] > 0
    end

    should "be able to read teams" do
      get api_v1_teams_path, headers: {:authorization => @token}
      assert_response :ok
    end

    should "be able to patch a team" do
      team = teams(:team1)
      patch api_v1_team_path(team), params:{:description => 'Updated Description'}, headers: {:authorization => @token}
      assert_response :ok
      json = JSON.parse(response.body)
      assert_equal json['description'], "Updated Description"
    end

    should "be able to put a team" do
      team = teams(:team1)
      put api_v1_team_path(team), params:{name:'N', :description => 'U'}, headers: {:authorization => @token}
      assert_response :ok
      json = JSON.parse(response.body)
      assert_equal json['name'], "N"
      assert_equal json['description'], "U"
    end

    should "be able to delete a team" do
      team = teams(:team1)
      delete api_v1_team_path(team), headers: {:authorization => @token}
      assert_response :ok
      get api_v1_team_path(team), headers: {:authorization => @token}
      assert_response :missing
    end
  end
end
