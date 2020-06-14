# frozen_string_literal: true
user = {
  email: "admin@mail.com",
  password: "11111111",
  password_confirmation: "11111111",
  first_name: "Admin",
  last_name: "Blog"
}

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

first_user = User.create!(email: user[:email],
            password: user[:password], 
            password_confirmation: user[:password_confirmation], 
            first_name: user[:first_name], 
            last_name: user[:last_name])

categories.each do |category|
  Category.create!(name: category[:name], description: category[:description], user_id: first_user.id)
end
