class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name, unique: true
    end

    create_table :ratings do |t|
      t.references :movie, foreign_key: true

      t.timestamps
    end

    create_table :category_ratings do |t|
      t.references :category, null: false, foreign_key: true
      t.references :rating, null: false, foreign_key: true
      t.integer :score, null: false, default: 0

      t.timestamps
    end

    Category.create(
      [
        { name: 'Performance' },
        { name: 'Special Effects' },
        { name: 'Storytelling' }
      ]
    )
  end
end
