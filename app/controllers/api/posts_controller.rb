# frozen_string_literal: true

class Api::PostsController < ApplicationController
  before_action :post, only: %i[show, destroy]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    render json: Post.where(category_id: params[:category_id])
  end

  def create
    category = Category.find(params[:category_id])
    post = Post.create((post_params).merge(category_id: category.id))
    if post.save
      render json: post, status: :ok
    else
      render json: { error: post.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: post
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_update_params)
      render json: post, status: :ok
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post.destroy!
    head :no_content
  end

  private

  def post_params
    params.require(:data).permit(:title, :content, :user_id)
  end

  def post_update_params
    params.require(:data).permit(:title, :content)
  end

  def post
    Post.find(params[:id])
  end
end
