class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :story, null: false, index: true, foreign_key: true
      t.string     :content, null: false
      t.string     :type, null: false

      t.timestamps  null: false
    end
  end
end
