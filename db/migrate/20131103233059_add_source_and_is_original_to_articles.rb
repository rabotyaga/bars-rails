# frozen_string_literal: true

class AddSourceAndIsOriginalToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :source, :string
    add_column :articles, :is_original, :boolean
  end
end
