require 'csv'
require_relative 'recipe.rb'

class Cookbook
  attr_accessor :repo
  def initialize(filename)
    # load the file, creates the recipe objects and stores them in Repo
    @repo = load_recipes(filename)
    @filename = filename
  end

  def all
    # returns all the recipes stored in repo
    @repo
  end

  def add_recipe(recipe)
    # add an object Recipe to the repository
    @repo << recipe
    update_csv_file
  end

  def remove_recipe(recipe_index)
    # remove an object recipe from the repository
    @repo.delete_at(recipe_index)
    update_csv_file
  end

  def find(index)
    @repo[index]
  end

  private

  def load_recipes(filename)
    data = CSV.read(filename, 'r')
    data.map { |recipe, time, diff, description| Recipe.new(recipe, time, diff, description) }
  end

  def update_csv_file
    CSV.open(@filename, "w") do |csv|
      @repo.each { |recipe| csv << [recipe.name, recipe.prep_time, recipe.difficulty, recipe.description] }
    end
  end
end
