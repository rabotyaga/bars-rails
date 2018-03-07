# frozen_string_literal: true

class CreateAlphabets < ActiveRecord::Migration
  def change
    create_table :alphabets do |t|
      t.integer :nr
      t.string :letter
      t.integer :nv
      t.string :name
      t.string :transcription
      t.string :ar_name
      t.string :ar_name_transcription
      t.boolean :has_all_writings

      t.timestamps null: false
    end
  end
end
