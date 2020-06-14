# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :email, :full_name

  has_many :categories
  has_many :posts 

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end