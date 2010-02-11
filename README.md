protected_parent_of
==============

Stops the deletion of an ActiveRecord object when members of a specified child association exist.

It adds a "removeable?" method to evaluate whether the object may be deleted and the necessary before_destroy callback.

Example Usage
-------------

The model 'has_many :posts'. Do not allow deletion if there are Post records associated with this object:
    
    protected_parent_of :posts
    
If it 'has_one :attachement', don't allow deletion until the attachment has been removed. Use the singular, just like the 'has_one'
    
    protected_parent_of :attachment
    
If necessary, allow several child objects to stay deletion. For example, a polymorphic category model may have:
    
    protected_parent_of :posts, :comments

License
-------
Copyright (c) 2010 Tim Harvey, released under the MIT license
