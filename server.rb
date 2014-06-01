require_relative 'server_methods'
require 'sinatra'
require 'pry'

get '/' do
	@recipes = get_recipes
	erb :index
end

get '/recipe/:recipe_id' do
	@recipe_id = params[:recipe_id]
	@recipe = find_recipe(@recipe_id)
	erb :recipe_page
end