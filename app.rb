require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook.rb'
require_relative 'recipe.rb'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @cookbook = Cookbook.new("views/recipes.csv")
  @recipes = @cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @cookbook = Cookbook.new("views/recipes.csv")
  #binding.pry
  @recipes = @cookbook.all
  @cookbook.add_recipe(Recipe.new(params[:recipe_name],params[:recipe_description], params[:recipe_preptime], params[:recipe_difficulty]))
  redirect '/'
end

get '/destroy/:id' do
  @cookbook = Cookbook.new("views/recipes.csv")
  #binding.pry
  @recipes = @cookbook.all
  # puts params[:id]
  @cookbook.remove_recipe(params[:id].to_i)
  # "The username is #{params[:index]}"
  redirect '/'
end

get '/about' do
  erb :about
end
