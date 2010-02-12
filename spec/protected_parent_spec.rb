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
  
  describe "removable? method" do
    it "should return true when there are no children for the instance" do
      category = Category.create
      category.removable?.should == true
    end
    
    it "should be false when the instance has only the firs of the two defined child record types" do
      category = Category.create
      category.posts << Post.new
      category.removable?.should == false
    end
    
    it "should be false when the instance has only the firs of the two defined child record types" do
      category = Category.create
      category.comments << Comment.new
      category.removable?.should == false
    end
    
    it "should be false when the instance has both of the two defined child record types" do
      category = Category.create
      category.posts << Post.new
      category.comments << Comment.new
      category.removable?.should == false
    end
  end
  
  describe "protected? method" do
    it "should return the opposite of removable?" do
      category = Category.create
      category.removable?.should == !category.protected?
      
      category = Category.create
      category.posts << Post.new
      category.removable?.should == !category.protected?
    end
  end
  describe "has an instance with a single 'has_one' child" do
    it "should allow delete if the instance doesn't have a child assigned" do
      category = Category.create
      lambda { category.destroy }.should change{ Category.count }
    end
    
    it "should block the delete if the instance has a child assigned" do
      category = Category.create
      category.attachment = Attachment.new
      lambda { category.destroy }.should_not change{ Category.count }
    end
  end
end