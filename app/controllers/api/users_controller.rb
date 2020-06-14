# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :user, only: %i[show, destroy]
  skip_before_action :verify_authenticity_token

  def index
    render json: User.all
  end

  def show
    render json: user
  end

  private

  def user
    User.find(params[:id])
  end
end
