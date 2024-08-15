class CreateJokes < ActiveRecord::Migration[7.2]
  def change
    create_table :jokes do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end
