class ImageUploadsController < ApplicationController
  require 'mini_magick'

def index
  @uploads = ImageUpload.all.order(created_at: :desc)
end

  def new
    @image_upload = ImageUpload.new
  end

  def create
    uploaded_io = params[:image_upload][:image]
    title = params[:image_upload][:title]

    if uploaded_io.present?
      filename = "#{Time.now.to_i}_#{uploaded_io.original_filename}"
      full_path = Rails.root.join('public/images/fulls', filename)
      thumb_path = Rails.root.join('public/images/thumbs', filename)

      # Save full image
      File.open(full_path, 'wb') { |f| f.write(uploaded_io.read) }

      # Create thumbnail
      image = MiniMagick::Image.open(full_path.to_s)
      image.resize "300x300"
      image.write(thumb_path.to_s)

      # Save record in DB
      @image_upload = ImageUpload.new(title: title, filename: filename)
      if @image_upload.save
        flash[:notice] = "Image uploaded successfully!"
        redirect_to image_uploads_path
      else
        flash[:alert] = "Failed to save image metadata."
        render :new
      end
    else
      flash[:alert] = "Please select an image."
      render :new
    end
  end


def delete
  @upload = ImageUpload.find(params[:id])

  file_path_thumb = Rails.root.join("public", "images", "thumbs", @upload.filename)
  file_path_full  = Rails.root.join("public", "images", "fulls", @upload.filename)

  File.delete(file_path_thumb) if File.exist?(file_path_thumb)
  File.delete(file_path_full)  if File.exist?(file_path_full)

  @upload.destroy

  redirect_to image_uploads_path, notice: "Image deleted successfully."
end

end
