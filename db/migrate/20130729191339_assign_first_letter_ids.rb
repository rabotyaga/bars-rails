# frozen_string_literal: true

class AssignFirstLetterIds < ActiveRecord::Migration
  def change
    FirstLetter.all.each do |fl|
      Article.where(id: (fl.first_article_id..fl.last_article_id)).update_all(first_letter_id: fl.id)
    end
  end
end
