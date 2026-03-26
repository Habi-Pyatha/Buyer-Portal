class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :address
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
