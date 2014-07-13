class ApplicationController < ActionController::Base

  private

  def ensure_required_create_params
    unprovided = required_create_params - params.keys
    failures = unprovided.each_with_object('') do |param, response|
      response << "'#{param}' parameter is required\n"
    end
    if failures.present?
      return render text: failures, status: :bad_request
    end
  end

end
