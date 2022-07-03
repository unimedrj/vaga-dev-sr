require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  rescue_from ActionController::UnknownFormat, with: :not_found!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  before_action :set_authenticity_token, if: -> { request.format.html? }

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

  def set_authenticity_token
    cookies[:_git_jmd_authenticity_token] = { value: form_authenticity_token, http_only: true }
  end

  # /usr/local/bundle/gems/actionpack-7.0.3/lib/action_controller/metal/request_forgery_protection.rb:306
  def request_authenticity_tokens
    super << cookies[:_git_jmd_authenticity_token]
  end
end
