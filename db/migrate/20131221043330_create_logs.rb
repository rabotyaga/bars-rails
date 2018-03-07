# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :user, index: true
      t.string :action
      t.references :article, index: true
      t.text :data

      t.timestamps
    end
  end
end
