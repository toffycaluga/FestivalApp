class AddDescriptionAndCountryToFestivals < ActiveRecord::Migration[7.0]
  def change
    add_column :festivals, :description, :text
    add_column :festivals, :country, :string
  end
end
