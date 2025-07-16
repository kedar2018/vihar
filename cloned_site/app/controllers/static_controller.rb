class StaticController < ApplicationController
  def home
    @uploads = ImageUpload.order(created_at: :desc)
  end
def upcomingtours
   @uploads = UpcomingTourImage.all
end
def contactus
  # no logic needed for now
end

end
