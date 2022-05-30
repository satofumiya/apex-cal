class CreateApexData < ActiveRecord::Migration[6.1]
  def change
    create_table :apex_data do |t|
      t.integer :damage
      t.integer :killassist
      t.integer :teamkill
      t.integer :ranking

      t.timestamps
    end
  end
end
