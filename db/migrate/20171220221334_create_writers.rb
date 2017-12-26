class CreateWriters < ActiveRecord::Migration[5.0]
  def change
    create_table :writers do |t|
      t.string :name
      t.string :city
      t.date :dob

      t.timestamps
    end

    create_table :books_writers, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :writer, index: true
    end

  end
end
