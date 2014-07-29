module Api
module Private
  class GoalsController < PrivateController

    before_filter :ensure_required_create_params,
                  :require_game

    def create
      unless params[:team].to_s.in? %w[silver black]
        return render json: {errors: ['Team must be "silver" or "black"']}
      end

      if scorer.score < 10
        time = params.fetch(:timestamp) { Time.now.to_i }
        team.score_goal!(time)
        if team.score == 10
          game.update ended: true
        end
        Resque.push 'metrics', class: 'MetricsGenerator'
      end

      Publisher.publish game

      render json: game
    end

    def cancel
      if team
        team.cancel_goal!
      end

      render json: game
    end

    private

    def scorer
      @_s ||= Scorer.new(team.id)
    end

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
