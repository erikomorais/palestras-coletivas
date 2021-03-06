require 'nokogiri'
require 'open-uri'

#:nodoc:
class Slideshare
  def self.frame(code)
    "<iframe class=\"embed-responsive-item\"
    src=\"https://www.slideshare.net/slideshow/embed_code/#{code}\"
    marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\"
    style=\"border:1px solid #CCC;border-width:1px 1px 0;
    margin-bottom:5px\"
    allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe>"
  end

  def self.extract(url)
    begin
      record = Nokogiri::XML(
        open("https://www.slideshare.net/api/oembed/2?url=#{url}&format=xml")
      )
    rescue OpenURI::HTTPError
      record = nil
    end

    fields(record)
  end

  def self.fields(record)
    unless record.nil?
      title = record.xpath('//title').text
      code = record.xpath('//slideshow-id').text
      thumbnail = record.xpath('//thumbnail').text

      { title: title, code: code, thumbnail: thumbnail, description: '' }
    end
  end
end
