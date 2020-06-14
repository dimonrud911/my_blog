# frozen_string_literal: true

class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  private

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource.errors, 401)
    end
  end

  def validation_error(errors, status)
    render json: { errors: errors }, status: status
  end
  
  def not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
