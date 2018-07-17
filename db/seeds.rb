# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.find_or_create_by(name: 'A', protein: 26)
Group.find_or_create_by(name: 'B', protein: 36)
Group.find_or_create_by(name: 'C', protein: 100)

Size.find_or_create_by(name: 'i', kcal: 200)
Size.find_or_create_by(name: 'ii', kcal: 325)
Size.find_or_create_by(name: 'iii', kcal: 450)
Size.find_or_create_by(name: 'iv', kcal: 575)
Size.find_or_create_by(name: 'v', kcal: 700)

Smoothie.all.destroy_all

[200, 325, 450, 575, 700].each do |cal|
  Smoothie.create(name: 'Apple & Blackberry Crumble' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Peachy Mangos' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Crushed Cherries' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Berry Bomb' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Banana Split' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Green Apple & Grapes' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Kiwi & Mango with Raisin' ,group_id: Group.find_by(name: 'A').id, size_id: Size.find_by(kcal: cal).id)

  Smoothie.create(name: 'Apple & Blackberry Crumble' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Strawberry' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Peachy Mangos' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Crushed Cherries' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Berry Bomb' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Tropical Fruit' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Kiwi & Mango' ,group_id: Group.find_by(name: 'B').id, size_id: Size.find_by(kcal: cal).id)

  Smoothie.create(name: 'Blueberry' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Summer Fruit Salad' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Crushed Cherries' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Tropical Fruit' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Cocao & Vanilla' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Raspberry' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
  Smoothie.create(name: 'Strawberry' ,group_id: Group.find_by(name: 'C').id, size_id: Size.find_by(kcal: cal).id)
end

# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)
# NutritionalInfo.find_or_create_by(smoothie_id:)

# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)
# Ingredient.find_or_create_by(name:)

# SmoothieIngredient.find_or_create_by(smoothie_id:, ingredient_id:)
# SmoothieIngredient.find_or_create_by(smoothie_id:, ingredient_id:)
# SmoothieIngredient.find_or_create_by(smoothie_id:, ingredient_id:)
# SmoothieIngredient.find_or_create_by(smoothie_id:, ingredient_id:)
# SmoothieIngredient.find_or_create_by(smoothie_id:, ingredient_id:)
