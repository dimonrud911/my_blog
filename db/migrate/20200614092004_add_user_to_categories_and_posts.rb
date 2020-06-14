class AddUserToCategoriesAndPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :user, index: true
    add_reference :posts, :user, index: true
  end
end
