class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.date :initial_date
      t.date :final_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
