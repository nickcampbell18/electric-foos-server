module Api
  module Public
    class StatsController < PublicController

      def index
        render json: GlobalStatistician.new
      end

    end
  end
end
