require File.dirname(__FILE__) + '/spec_helper'

describe "ProtectedParent" do
  describe "with an instance that does not have associated records" do
    it "should allow a destroy" do
      category = Category.create
      lambda { category.destroy }.should change{ Category.count }
    end
  end  
  
  describe "with an instance that has associated records" do
    it "should block the destroy" do
      category = Category.create
      category.posts << Post.new
      category.save!
      lambda { category.destroy }.should_not change{ Category.count }
    end
  end
end