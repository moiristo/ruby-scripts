require 'open-uri'
require 'json'

class Rtlxl

  FORMATS = %w(progressive adaptive smooth)
  DEVICES = %w(a2t a3t nettv)

  METADATA_TEMPLATE = "http://www.rtl.nl/system/s4m/vfd/version=2/d=%{device}/fmt=%{format}/uuid=%{uuid}/output=json/"

  # Example: https://www.rtl.nl/video/44adc1a5-0d4b-3718-b558-54d21318c16d/
  def initialize url:, format: nil, device: nil
    @url = url.to_s
    @uuid = @url[/\w+-\w+-\w+-\w+-\w+/]
    @format = FORMATS.include?(format) ? format : 'progressive'
    @device = DEVICES.include?(device) ? device : 'nettv'
  end

  def valid?
    !@uuid.nil?
  end

  def metadata_url
    METADATA_TEMPLATE % { uuid: @uuid, device: @device, format: @format }
  end

  def video_url
    metadata = JSON.parse open(metadata_url, read_timeout: 5, open_timeout: 5).read

    if metadata && metadata.dig('meta', 'nr_of_videos_total') > 0
      metadata.dig('meta', 'videohost') + metadata['material'].first['videopath']
    else
      "No available videos found for the given URL"
    end
  rescue => e
    "Could not fetch video URL: #{e.message}"
  end

end
