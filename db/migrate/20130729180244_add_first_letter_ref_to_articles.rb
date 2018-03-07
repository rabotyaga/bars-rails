# frozen_string_literal: true

class AddFirstLetterRefToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :first_letter, index: true
  end
end
