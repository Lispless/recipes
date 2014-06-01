require_relative 'server_methods'
require 'sinatra'
require 'pry'

get '/' do
	@recipes = get_recipes
	erb :index
end

get '/recipe/:recipe_id' do
	@recipe = find_recipe(params[:recipe_id])
	erb :recipe_page
end