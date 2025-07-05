class StaticController < ApplicationController
  def home
    @uploads = ImageUpload.order(created_at: :desc)
  end
end
