class CreateListUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :list_users do |t|
      t.belongs_to :list
      t.belongs_to :user

      t.timestamps
    end
  end
end
