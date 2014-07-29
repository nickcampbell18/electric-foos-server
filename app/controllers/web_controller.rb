class WebController < ApplicationController

  def index
    metrics = Metrics.new
    @players_and_scores = metrics.all_goals
  end

end
