module Api
module Private
  class GoalsController < PrivateController

    before_filter :ensure_required_create_params,
                  :require_game

    def create
      unless params[:team].to_s.in? %w[silver black]
        return render json: {errors: ['Team must be "silver" or "black"']}
      end

      if team.score < 10
        tstamp = URI.decode(params[:timestamp])
        time = Time.parse(tstamp)
        binding.pry
        goal_time = (time - game.created_at).to_i
        team.score_goal! goal_time
        game.finish!(team) if team.score == 10
      end

      Resque.push 'metrics', class: 'PlayerStatistician'
      Resque.push 'metrics', class: 'GlobalStatistician'
      Publisher.publish game

      render json: game
    end

    def cancel
      if team
        score = team.score
        team.cancel_goal!
        game.unfinish!(team) if score == 10
      end

      Publisher.publish game

      render json: game
    end

    private

    def team
      @_t ||= Team.find_by_game_and_colour(game, params[:team])
    end

    def require_game
      unless game
        return render json: {errors: ['Game not found.']}
      end
    end

    def game
      @_g ||= Game.find params[:game_id]
    end

    def timestamp
      Time.parse params[:timestamp]
    end

    def required_create_params
      %w[game_id team timestamp]
    end

  end
end
end
