# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name

      t.timestamps
    end
    Action.create(name: 'Создание')
    Action.create(name: 'Изменение')
    Action.create(name: 'Удаление')
  end
end
