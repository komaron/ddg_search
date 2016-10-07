require 'ddg-wrapper'
require 'json'
require 'sinatra'

class Application < Sinatra::Base

 configure do
    set :haml, format: :html5
  end

  get "/" do
  	haml :index,
  	 locals: get_results(params[:q])
  end

  def get_results(query)
  	client = DDG::Wrapper::Client.new
  	resp = client.query(query)
  	resp
  end

  def build_data(resp)
  	data = {}
  	resp['RelatedTopics'].each do |result|
  		 if result.keys.include?('Topics')
  		data[:title] = result['FirstURL'].split('/')[3].gsub("_"," ")
  		data[:url] = result['FirstURL']
  		data[:logo] = result['Icon']['URL']
  	end
  	data
  end
end