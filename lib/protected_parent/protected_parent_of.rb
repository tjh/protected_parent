module ProtectedParent
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    def protected_parent_of(*children_names)
      cattr_accessor :children_of_protected_parent                                # Define a method to hold the children methods
      self.children_of_protected_parent ||= []                                    # Set the initial value, only if nil
      children_names.each do |child_name|                                         # Loop through the children given
        self.children_of_protected_parent << child_name.to_s                      # Add each to the array
      end
      
      before_destroy :removable?                                                  # Create the callback to block deletes if appropriate
      send :include, InstanceMethods                                              # Add the methods needed
    end
  end
  
  module InstanceMethods
    def removable?
      self.class.children_of_protected_parent.each do |child|                     # Loop through all the children 
        if a_plural child
          return false if send("#{child}").size > 0                               # For plural children, see if there's at least 1
        else
          return false unless send("#{child}").nil?                               # For singular children, make sure it's not nil
        end
      end
      true
    end
    
    def a_plural(child)
      child.pluralize == child
    end
  end
end

ActiveRecord::Base.send :include, ProtectedParent