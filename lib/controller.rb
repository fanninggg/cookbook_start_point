require_relative 'recipe'
require_relative 'view'
require 'open-uri'
require 'nokogiri'

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
    prep_time = @view.ask_for_prep_time
    recipe = Recipe.new(name, description, prep_time, false)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    to_destroy = @view.ask_for_index
    @cookbook.remove_recipe(to_destroy)
  end

  def import
    # Ask a user for a keyword to search
    keyword = @view.ask_for_keyword
    # Make an HTTP request to the recipe's website with our keyword
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{keyword}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    recipes_array = []

    # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
    html_doc.search('.recette_classique').first(5).each do |element|
      name = element.search('.m_titre_resultat a').text.strip
      description = element.search('.m_texte_resultat').text.strip
      prep_time = element.search('.m_detail_time').text.strip
      recipes_array << Recipe.new(name, description, prep_time, false)
    end
    # Display them in an indexed list
    @view.list_recipes(recipes_array)

    # Ask the user which recipe they want to import (ask for an index)
    index = @view.ask_for_index

    # Find the recipe
    chosen_recipe = recipes_array[index]

    # Add it to the Cookbook
    @cookbook.add_recipe(chosen_recipe)
  end

  def mark_as_done
    # List recipes
    list

    # Ask the user which recipe is done
    index = @view.ask_for_index

    # Find the recipe using the index provided
    recipe = @cookbook.find(index)

    # Mark the recipe as done
    recipe.mark
    @cookbook.save_to_csv
  end
end
