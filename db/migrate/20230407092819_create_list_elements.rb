class CreateListElements < ActiveRecord::Migration[7.0]
  def change
    create_table :list_elements do |t|
      t.belongs_to :list
      t.text :description
      t.integer :position, null: false

      t.timestamps
    end
  end
end
