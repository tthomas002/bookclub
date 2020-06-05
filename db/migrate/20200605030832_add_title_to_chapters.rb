class AddTitleToChapters < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :title, :string
  end
end
