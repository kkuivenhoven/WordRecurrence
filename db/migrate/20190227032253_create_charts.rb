class CreateCharts < ActiveRecord::Migration[5.0]
  def change
    create_table :charts do |t|
      t.string :type
      t.integer :chapter

      t.timestamps
    end
  end
end
