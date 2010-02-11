module ProtectedParent
  module ClassMethods
    def protected_parent_of(*children_names)
      before_destroy :removable?
      
      define_method :removable? do
        can_delete = true
        children_names.each do |child|
          record_count = send("#{child.to_s}").count
          can_delete = false if record_count > 0
        end
        can_delete
      end
    end
  end
  
  def self.included(receiver)
    receiver.extend  ClassMethods
  end
end
