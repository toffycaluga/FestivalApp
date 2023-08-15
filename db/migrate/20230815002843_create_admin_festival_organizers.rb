class CreateAdminFestivalOrganizers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_festival_organizers do |t|
      t.references :festival, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
