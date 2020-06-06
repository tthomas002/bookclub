class AddNumberToChapters < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :number, :integer
  end
end
