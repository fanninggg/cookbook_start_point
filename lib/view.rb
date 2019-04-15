class View
  def list_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      marked = recipe.done ? "[x]" : "[ ]"
      puts "#{index + 1}. #{marked} #{recipe.name} | #{recipe.prep_time} - #{recipe.description}"
    end
  end

  def ask_for_name
    puts "What is the name of the recipe?"
    return gets.chomp
  end

  def ask_for_description
    puts "What is the description?"
    return gets.chomp
  end

  def ask_for_keyword
    puts "What is the search term?"
    return gets.chomp
  end

  def ask_for_prep_time
    puts "What is the prep time?"
    return gets.chomp
  end

  def ask_for_index
    puts "Which recipe?"
    gets.chomp.to_i - 1
  end
end
