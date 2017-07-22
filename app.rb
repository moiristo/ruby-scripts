get '/' do
  "Sinatra Heroku Cedar Template - The bare minimum for a sinatra app on cedar, running rack, and using bundler."
end

get '/rtlxl' do
  rtlxl = Rtlxl.new(url: params['url'], device: params['device'], format: params['format'])
  rtlxl.valid? ? rtlxl.video_url : 'No UUID found, is the passed URL correct?'
end
