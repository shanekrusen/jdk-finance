class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|
      t.decimal :value, :precision => 8, :scale => 2
      t.integer :category_id
      t.date :date

      t.timestamps
    end
  end
end
