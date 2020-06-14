# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[create]
  clear_respond_to
  respond_to :json
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  skip_before_action :verify_authenticity_token

  def create
    build_resource(configure_sign_up_params)

    resource.save
    render_resource(resource)
  end

  protected

  def configure_sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
