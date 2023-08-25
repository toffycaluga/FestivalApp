class AddTermsAndConditionsAcceptedToApply < ActiveRecord::Migration[7.0]
  def change
    add_column :applies, :terms_and_conditions_accepted, :boolean , default: false
  end
end
