class CreateInitialTables < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :text, null: false
      t.timestamps
    end

    create_table :games do |t|
      t.references :word, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.text :guesses
      t.boolean :completed, default: false
      t.timestamps
    end

    create_table :players do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :sessions do |t|
      t.string :id, null: false, primary_key: true
      t.references :player, null: false, foreign_key: true
      t.timestamps
    end

    add_index :words, :text, unique: true
  end
end
