class AddCcColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    create_column :users, :cc_csv, :integer
    create_column :users, :cc_exp, :date
    create_column :users, :bill_zip, :integer
  end
end
