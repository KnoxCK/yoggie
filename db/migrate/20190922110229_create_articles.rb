class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.boolean :published
      t.string :cover_image
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
