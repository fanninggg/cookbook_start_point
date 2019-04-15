require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    read_csv
  end

  def all
    return @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done]
      end
    end
  end

  def read_csv
    CSV.foreach(@csv_file_path) do |row|
      boolean = row[3] == 'true'
      @recipes << Recipe.new(row[0], row[1], row[2], boolean)
    end
  end
end
