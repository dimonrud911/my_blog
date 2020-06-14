# frozen_string_literal: true

class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :description
 
  belongs_to :user
  has_many :posts
end
