require_relative '../../test_helper.rb'

module Api
  class GamesControllerTest < ActionController::TestCase

    def setup
      @game = Game.create
      login_with_api_token!
    end


    #
    # GET
    #

    test 'it can show the game' do
      get :show, id: @game.id, format: :json
      assert_response :success
      assert_equal 'game', res_json['type']
    end

    test 'it returns 404 if the game is not found' do
      get :show, id: -1, format: :json
      assert_response :not_found
    end



    #
    # CREATE
    #

    test 'it can create a game successfully' do
      post :create, create_params
      assert_response :created
      game = res_json
      assert game['id']
      assert_equal false, game['ended']
      assert_empty game['teams']
      assert_equal Game::FINAL_SCORE, game['final_score']
    end

    test 'it should fail if there is no timestamp' do
      params = create_params.dup
      params.delete(:timestamp)
      post :create, params
      assert_response :bad_request
      assert_includes res_json['errors'],
        "'timestamp' parameter is required"
    end

    test 'it should fail if there are no silver team players in string' do
      params = create_params.merge(silver_team: '')
      post :create, params
      assert_response :bad_request
      assert_match /Must provide at least/, res_json['errors']
    end

    test 'it should fail if there are no silver team players in collection' do
      params = create_params.merge(silver_team: [])
      post :create, params
      assert_response :bad_request
      assert_match /Must provide at least/, res_json['errors']
    end

    private

    def create_params
      {
        timestamp: Time.now.iso8601,
        silver_team: %w[mario nick],
        black_team:  %w[ray francesco],
        format: :json
      }
    end

  end
end
