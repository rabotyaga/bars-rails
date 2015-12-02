class AddAr123wovowelsnhamzaToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :ar123_wo_vowels_n_hamza, :string
  end
end
