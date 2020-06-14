# frozen_string_literal: true

class PostSerializer < ApplicationSerializer
  attributes :id, :title, :content

  belongs_to :user
  belongs_to :category
end
