class SitemapController < ApplicationController
  layout nil

  def index
    @static_urls = [
      root_url,
      contactus_url,
      upcomingtours_url,
      new_image_upload_url,
      image_uploads_url,
      upcoming_tour_images_url
    ]

    @image_uploads = ImageUpload.all
    @upcoming_tour_images = UpcomingTourImage.all
  end
end
