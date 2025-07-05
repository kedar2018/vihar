class CreateImageUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :image_uploads do |t|
      t.string :title
      t.string :filename

      t.timestamps
    end
  end
end
