require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')
    yield(connection)
  ensure
    connection.close
  end
end

def get_recipes()
  query = " SELECT DISTINCT ON (recipes.name) recipes.id AS recipe_id, recipes.name AS name, recipes.instructions AS instructions, recipes.description AS description, ingredients.name AS ingredients
            FROM recipes
            JOIN ingredients ON ingredients.recipe_id = recipes.id
            ORDER BY name;"

  recipes = db_connection do |conn|
    conn.exec(query)
  end

  recipes = recipes.to_a
  return recipes
end

def find_recipe(id)
  query = "SELECT DISTINCT ON (recipes.name) recipes.id AS recipe_id, recipes.name AS name, recipes.instructions AS instructions, recipes.description AS description, ingredients.name AS ingredients
          FROM recipes
          JOIN ingredients ON ingredients.recipe_id = recipes.id
          WHERE recipes.id = $1"
  recipe = db_connection do |conn|
    conn.exec_params(query, [id])
  end
  recipe = recipe.to_a
  return recipe
end