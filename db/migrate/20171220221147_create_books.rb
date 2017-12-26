class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :pages
      t.boolean :leased
      t.integer :year
      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
