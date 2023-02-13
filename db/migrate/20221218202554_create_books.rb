class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.date :proposal_date
      t.date :contract_date
      t.date :published_date
      t.integer :units_sold
      t.text :notes
      t.boolean :active

      t.timestamps
    end
  end
end
