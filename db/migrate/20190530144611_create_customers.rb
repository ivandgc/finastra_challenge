class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :api_key
      t.string :query_type
      t.string :language
      t.string :response_output
      t.integer :locations

      t.timestamps
    end
  end
end
