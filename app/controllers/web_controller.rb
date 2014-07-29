class WebController < ApplicationController

  def index
    metrics = Metrics.new
    @players_and_scores = metrics.top_players
    @teams_and_scores   = metrics.top_teams
  end

end
