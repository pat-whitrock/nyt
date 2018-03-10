class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string     :byline
      t.string     :headline, null: false
      t.datetime   :last_published, null: false
      t.text       :summary, null: false
      t.string     :url, null: false

      t.timestamps null: false
    end
  end
end
