class Category < ActiveRecord::Base
  has_many :posts
  has_many :comments
  
  protected_parent_of :posts, :comments
end