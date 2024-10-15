class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :movie, foreign_key: true
      t.column :categories, :json, default: {} # json for sqlite, jsonb for postgres
      t.decimal :score, precision: 8, scale: 2

      t.timestamps
    end
  end
end
