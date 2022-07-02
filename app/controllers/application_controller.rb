require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  rescue_from ActionController::UnknownFormat, with: :not_found!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  private

  def not_found!
    if request.format.json?
      render json: {}, status: :not_found
    elsif Rails.env.development?
      raise ActionController::RoutingError,
            "No route matches [#{request.env['REQUEST_METHOD']}] #{request.env['PATH_INFO'].inspect}"
    else
      render file: Rails.root.join('public/404.html'), layout: false, status: :not_found
    end
  end
end
