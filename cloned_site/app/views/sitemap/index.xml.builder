xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do

  @static_urls.each do |url|
    xml.url do
      xml.loc url
      xml.changefreq "weekly"
      xml.priority "0.8"
    end
  end

  @image_uploads.each do |upload|
    xml.url do
      xml.loc image_upload_url(upload)
      xml.lastmod upload.updated_at.strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.6"
    end
  end

  @upcoming_tour_images.each do |upload|
    xml.url do
      xml.loc upcoming_tour_image_url(upload)
      xml.lastmod upload.updated_at.strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.6"
    end
  end

end
