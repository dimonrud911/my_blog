# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  private

  def respond_with(_resource, _opts = {})
    render json: { token: current_token, email: resource.email, full_name: resource.full_name }
  end

  def respond_to_on_destroy
    head :no_content
  end
end
