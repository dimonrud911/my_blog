# frozen_string_literal: true

categories = [
  {
    name: 'Technology',
    description: 'The modern technologies of the world'
  },
  {
    name: 'Business',
    description: 'Share your opinion How to create a successful business'
  },
  {
    name: 'Social media',
    description: 'All you need to know about social media'
  }
]
categories.each do |category|
  Category.create!(name: category[:name], description: category[:description])
end
