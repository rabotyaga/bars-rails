# frozen_string_literal: true

class MarkOriginalArticles < ActiveRecord::Migration
  def change
    Article.all.update_all(is_original: true)
  end
end
