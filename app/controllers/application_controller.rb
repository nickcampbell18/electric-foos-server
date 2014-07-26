class ApplicationController < ActionController::Base

  attr_accessor :current_user

  private

  def ensure_required_create_params
    unprovided = required_create_params - params.keys
    failures = unprovided.each_with_object([]) do |param, response|
      response << "'#{param}' parameter is required"
    end
    if failures.present?
      return render json: {errors: failures}, status: :bad_request
    end
  end

  def coerce_array(string)
    if string.is_a?(String)
      string.split(',')
    else
      string.to_a
    end
  end

end
