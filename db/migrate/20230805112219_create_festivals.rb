class CreateFestivals < ActiveRecord::Migration[7.0]
  def change
    create_table :festivals do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.boolean :state, default: true
      t.boolean :application_state, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
