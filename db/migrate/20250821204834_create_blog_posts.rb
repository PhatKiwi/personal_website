class CreateBlogPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.boolean :published
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
