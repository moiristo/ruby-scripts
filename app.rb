get '/' do
  "Sinatra Heroku Cedar Template - The bare minimum for a sinatra app on cedar, running rack, and using bundler."
end

get '/rtlxl' do
  rtlxl = Rtlxl.new(url: params['url'], device: params['device'], format: params['format'])
  if rtlxl.valid?
    video_url = rtlxl.video_url
    if video_url.start_with?('http') && params['redirect'] != '0'
      redirect video_url
    else
      video_url
    end
  else
    'No UUID found, is the passed URL correct?'
  end
end
