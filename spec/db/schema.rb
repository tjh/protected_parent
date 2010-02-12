ActiveRecord::Schema.define(:version => 0) do
  create_table :categories, :force => true do |t|
    t.column :name, :string
  end  
  
  create_table :posts, :force => true do |t|
    t.column :category_id, :integer
  end
 
  create_table :comments, :force => true do |t|
    t.column :category_id, :integer
  end
 
  create_table :attachments, :force => true do |t|
    t.column :category_id, :integer
  end
end