class AddQuedoEnFestivalToApplies < ActiveRecord::Migration[7.0]
  def change
    add_column :applies, :quedo_en_festival, :boolean, default: false
  end
end
