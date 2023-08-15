class CreateApplies < ActiveRecord::Migration[7.0]
  def change
    create_table :applies do |t|
      t.string :name
      t.string :act
      t.text :description
      t.string :video_url
      t.references :festival, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
