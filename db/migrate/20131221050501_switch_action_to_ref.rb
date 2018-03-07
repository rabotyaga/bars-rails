# frozen_string_literal: true

class SwitchActionToRef < ActiveRecord::Migration
  def change
    remove_column :logs, :action
    add_reference :logs, :action, index: true
  end
end
