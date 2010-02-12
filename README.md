protected_parent_of
==============

Stops the deletion of an ActiveRecord object when members of a specified child association exist.

It adds a "removeable?" method to evaluate whether the object may be deleted and the necessary before_destroy callback.

Example Usage
-------------

The model 'has_many :posts'. Do not allow deletion if there are Post records associated with this object:
    
    class Category < ActiveRecord::Base
      protected_parent_of :posts
    end
    
If it 'has_one :attachement', don't allow deletion until the attachment has been removed. Use the singular, just like the 'has_one'
    
    class Category < ActiveRecord::Base
      protected_parent_of :attachment
    end
    
If necessary, allow several child objects to stay deletion. For example, a polymorphic category model may have:
    
    class Category < ActiveRecord::Base
      protected_parent_of :posts, :comments
    end
    
Depending on taste, you can call protected_parent_of multiple times:
    
    class Category < ActiveRecord::Base
      has_many :posts
      has_many :comments
      protected_parent_of :posts, :comments
      
      has_one :attachment
      protected_parent_of :attachment
    end
    

License
-------
Copyright (c) 2010 Tim Harvey, released under the MIT license
