# frozen_string_literal: true

class CreateFirstLetters < ActiveRecord::Migration
  def change
    create_table :first_letters do |t|
      t.string :letter
      t.string :notes
      t.integer :first_article_id
      t.integer :last_article_id

      t.timestamps
    end

    articles = Article.where("length(ar_inf)=1 and translation like '%буква%'").order(:id)
    next_l_ids = articles.map(&:id).rotate
    next_l_ids.pop
    next_l_ids.push(Article.last!.id)
    articles.each_index do |i|
      FirstLetter.create!(letter: articles[i].ar_inf, notes: articles[i].translation, first_article_id: articles[i].id, last_article_id: next_l_ids[i] - 1)
    end
  end
end
