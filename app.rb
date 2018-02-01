class App < Sinatra::Base
  TITLE = "Workshop DB"
  register Sinatra::ActiveRecordExtension

  get '/' do
    haml :index
  end

end
