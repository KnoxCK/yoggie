# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(email: 'admin@yoggie.co.uk', password: '123456', admin: true, accepted_terms: true) if Rails.env.development?

Group.find_or_create_by(name: 'A', protein: 26)
Group.find_or_create_by(name: 'B', protein: 36)
Group.find_or_create_by(name: 'C', protein: 100)
Group.find_or_create_by(name: 'Std')

Size.find_or_create_by(name: 'i', kcal: 200)
Size.find_or_create_by(name: 'ii', kcal: 325)
Size.find_or_create_by(name: 'iii', kcal: 450)
Size.find_or_create_by(name: 'iv', kcal: 575)
Size.find_or_create_by(name: 'v', kcal: 700)

filepath = 'ingredients.csv'
CSV.foreach(filepath) do |row|
  puts "#{row}"
  Ingredient.create!(name: row[0].downcase.tr(' ', '_'), allergen: row[1], special: row[2], superfood: row[3], contents: row[4], image: row[5])
end

filepath = 'badges.csv'
CSV.foreach(filepath) do |row|
  puts "#{row}"
  Badge.create!(name: row[0].downcase.tr(' ', '_'), image: row[1])
end

filepath = 'smoothies.csv'
Size.all.each do |size|
  CSV.foreach(filepath) do |row|
    puts "#{size.name} - #{row}"
    smoothie = Smoothie.create!(name: row[0].downcase.tr(' ', '_'), group_id: Group.find_by(name: row[1]).id, size_id: size.id,
                                number: row[2].to_i, description: row[3], great_with: row[4], ingredient_description: row[5],
                                story: row[6], benefits_one: row[7], benefits_two: row[8], benefits_three: row[9],
                                when: row[10], contains: row[11], superfood: row[12].downcase.tr(' ', '_'), image: row[42], logo: row[43])
    NutriInfo.create!(smoothie_id: smoothie.id, energy_kJ: row[13].to_f, energy_kcal: row[14].to_f, fat_g: row[15].to_f, fat_saturates_g: row[16].to_f,
                      carbs_g: row[17].to_f, carbs_sugars_g: row[18].to_f, fibre_g: row[19].to_f, protein_g: row[20].to_f, salt_g: row[21].to_f)
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[22].downcase.tr(' ', '_')).id, large: true, special: false)
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[23].downcase.tr(' ', '_')).id, large: true, special: false) unless row[23].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[24].downcase.tr(' ', '_')).id, large: true, special: false) unless row[24].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[25].downcase.tr(' ', '_')).id, large: true, special: false) unless row[25].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[26].downcase.tr(' ', '_')).id, large: false, special: false)
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[27].downcase.tr(' ', '_')).id, large: false, special: false) unless row[27].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[28].downcase.tr(' ', '_')).id, large: false, special: false) unless row[28].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[29].downcase.tr(' ', '_')).id, large: false, special: false) unless row[29].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[30].downcase.tr(' ', '_')).id, large: false, special: false) unless row[30].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[31].downcase.tr(' ', '_')).id, large: false, special: false) unless row[31].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[32].downcase.tr(' ', '_')).id, large: false, special: false) unless row[32].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[33].downcase.tr(' ', '_')).id, large: false, special: false) unless row[33].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[34].downcase.tr(' ', '_')).id, large: false, special: false) unless row[34].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[35].downcase.tr(' ', '_')).id, large: false, special: true) unless row[35].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[36].downcase.tr(' ', '_')).id, large: false, special: true) unless row[36].nil?
    SmoothieIngredient.create!(smoothie_id: smoothie.id, ingredient_id: Ingredient.find_by(name: row[37].downcase.tr(' ', '_')).id, large: false, special: true) unless row[37].nil?
    SmoothieBadge.create!(smoothie_id: smoothie.id, badge_id: Badge.find_by(name: row[38].downcase.tr(' ', '_')).id)
    SmoothieBadge.create!(smoothie_id: smoothie.id, badge_id: Badge.find_by(name: row[39].downcase.tr(' ', '_')).id) unless row[39].nil?
    SmoothieBadge.create!(smoothie_id: smoothie.id, badge_id: Badge.find_by(name: row[40].downcase.tr(' ', '_')).id) unless row[40].nil?
    SmoothieBadge.create!(smoothie_id: smoothie.id, badge_id: Badge.find_by(name: row[41].downcase.tr(' ', '_')).id) unless row[41].nil?
  end
end
