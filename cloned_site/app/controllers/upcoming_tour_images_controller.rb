class UpcomingTourImagesController < ApplicationController
  before_action :set_upcoming_tour_image, only: %i[ show edit update destroy ]

  # GET /upcoming_tour_images or /upcoming_tour_images.json
  def index
    @upcoming_tour_images = UpcomingTourImage.all
  end

  # GET /upcoming_tour_images/1 or /upcoming_tour_images/1.json
  def show
  end

  # GET /upcoming_tour_images/new
  def new
    @upcoming_tour_image = UpcomingTourImage.new
  end

  # GET /upcoming_tour_images/1/edit
  def edit
  end

def create
  @upcoming_tour_image = UpcomingTourImage.new(title: params[:upcoming_tour_image][:title])

  uploaded_io = params[:image_file]
  if uploaded_io.present?
    filename = SecureRandom.hex + File.extname(uploaded_io.original_filename)
    full_path = Rails.root.join('public/images/fulls', filename)
    thumb_path = Rails.root.join('public/images/thumbs', filename)

    # Save original
    File.open(full_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    # Create a thumbnail (optional: using MiniMagick if available)
    if defined?(MiniMagick)
      image = MiniMagick::Image.open(full_path.to_s)
      image.resize "300x300"
      image.write(thumb_path.to_s)
    else
      # fallback: just copy the original to thumbs
      FileUtils.cp(full_path, thumb_path)
    end

    @upcoming_tour_image.filename = filename
  end

  if @upcoming_tour_image.save
    redirect_to @upcoming_tour_image, notice: "Image uploaded successfully."
  else
    render :new, status: :unprocessable_entity
  end
end

  # PATCH/PUT /upcoming_tour_images/1 or /upcoming_tour_images/1.json
  def update
    respond_to do |format|
      if @upcoming_tour_image.update(upcoming_tour_image_params)
        format.html { redirect_to @upcoming_tour_image, notice: "Upcoming tour image was successfully updated." }
        format.json { render :show, status: :ok, location: @upcoming_tour_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @upcoming_tour_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /upcoming_tour_images/1 or /upcoming_tour_images/1.json
  def destroy
    @upcoming_tour_image.destroy!

    respond_to do |format|
      format.html { redirect_to upcoming_tour_images_path, status: :see_other, notice: "Upcoming tour image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upcoming_tour_image
      @upcoming_tour_image = UpcomingTourImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upcoming_tour_image_params
      params.require(:upcoming_tour_image).permit(:title, :filename)
    end
end
