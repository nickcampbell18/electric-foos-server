module Api
  module Public
    class StatsController < PublicController

      def index
        render json: DummyStats.new
      end

    end
  end
end
