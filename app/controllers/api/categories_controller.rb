# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  before_action :category, only: %i[show, destroy]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    render json: Category.all
  end

  def create
    category = Category.create(category_params)
    if category.save
      render json: category, status: :ok
    else
      render json: { error: category.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: category
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_update_params)
      render json: category, status: :ok
    else
      render json: { error: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    category.destroy!
    head :no_content
  end

  private

  def category_params
    params.require(:data).permit(:name, :description, :user_id)
  end

  def category_update_params
    params.require(:data).permit(:name, :description)
  end

  def category
    Category.find(params[:id])
  end
end
