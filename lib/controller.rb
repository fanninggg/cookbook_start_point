require_relative 'recipe'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    list = @cookbook.all
    @view.list_recipes(list)
  end

  def create
    name = @view.ask_for_name
    description = @view.ask_for_description
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    to_destroy = @view.ask_for_index
    @cookbook.remove_recipe(to_destroy)
  end
end
