class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.symbol :status

      t.timestamps
    end
  end
end
