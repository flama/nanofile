class CreateButtonUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :button_uploads do |t|
      t.text :image_data
    end
  end
end
