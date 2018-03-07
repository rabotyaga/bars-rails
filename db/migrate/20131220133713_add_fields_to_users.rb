# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :can_edit, :boolean
    add_column :users, :can_add, :boolean
    add_column :users, :can_delete, :boolean
  end
end
