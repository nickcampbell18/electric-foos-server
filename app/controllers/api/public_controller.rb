module Api
  class PublicController < ::ApplicationController
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def not_found
      return render status: 404, json: {error: 'Could not find that, sorry.'}
    end
  end
end
