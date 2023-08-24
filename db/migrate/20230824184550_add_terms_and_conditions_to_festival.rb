class AddTermsAndConditionsToFestival < ActiveRecord::Migration[7.0]
  def change
    add_column :festivals, :terms_and_conditions, :text, default: 'Términos y condiciones por defecto.'
  end
end
