class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :nr
      t.string :ar_inf
      t.string :form
      t.string :opt
      t.string :mn1
      t.string :ar1
      t.string :mn2
      t.string :ar2
      t.string :mn3
      t.string :ar3
      t.text :translation
      t.text :notes

      t.timestamps
    end
  end
end
