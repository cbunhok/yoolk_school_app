class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :short_title
      t.integer :duration
      t.integer :category_id
      t.integer :cost_per_day
      t.string :summary
      t.boolean :is_published

      t.timestamps
    end
  end
end
