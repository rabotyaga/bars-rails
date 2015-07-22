class AddFieldsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :page, :integer
    add_column :articles, :is_root, :boolean
    add_reference :articles, :root, index: true
  end
end
