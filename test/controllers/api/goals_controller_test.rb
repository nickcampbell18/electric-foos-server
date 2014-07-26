require_relative '../../test_helper.rb'

module Api
  class GoalsControllerTest < ActionController::TestCase

    def setup
      @game = Game.create
      @silvers = @game.teams.create team_colour: :silver
      login_with_api_token!
    end

    test 'can increment the score for a team' do
      initial_score = @game.teams.first['score']
      params = {
        timestamp: Time.now.iso8601,
        format:    :json,
        game_id:   @game.id,
        team:      :silver
      }
      post :create, params

      silver_team = res_json['teams'].first
      refute_equal initial_score,
        silver_team['score']
    end

    test 'team must be silver or black' do
      params = {
        format:    :json,
        game_id:   @game.id,
        team:      :blue,
        timestamp: Time.now.iso8601
      }
      post :create, params

      assert_match /must be "silver" or "black"/,
        res_json['errors'][0]
    end

  end
end
