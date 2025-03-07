class CreateItemPackages < ActiveRecord::Migration[8.0]
  def change
    create_table :item_packages do |t|
      t.string :name
      t.string :contents

      t.timestamps
    end
  end
end
