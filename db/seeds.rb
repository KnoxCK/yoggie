# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
SmoothieIngredient.destroy_all
SmoothieBadge.destroy_all
BasketSmoothie.destroy_all
Badge.destroy_all
Ingredient.destroy_all
NutriInfo.destroy_all
Smoothie.destroy_all
Basket.destroy_all
Address.destroy_all
Customer.destroy_all
User.destroy_all

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

# get available ingredient and smoothie image strings
ingredient_image_strings = Dir.entries(Rails.root.join('seed_assets', 'ingredient_images_oct_11'))
smoothie_image_strings = Dir.entries(Rails.root.join('seed_assets', 'smoothie_images_oct_11'))

smoothie_images_count = 0
ingredient_images_count = 0

# To be determined = delete first column and no superfood
filepath = 'seed_assets/smoothies_data_oct_11/Ingredients-Table.csv'
CSV.foreach(filepath, {col_sep: ';'}) do |row|
  puts "#{row}"
  i = Ingredient.new(
    name: row[0].downcase.tr(' ', '_'),
    allergen: row[1],
    special: row[2],
    contents: row[3])

  if ingredient_image_strings.include?(row[5])
    ingredient_images_count += 1
    if Rails.env.production?
      i.remote_photo_url = Rails.root.join('seed_assets', 'ingredient_images_oct_11', row[5]).to_s
    else
      i.image = row[5]
    end
  end
  i.save!
end

filepath = 'seed_assets/smoothies_data_oct_11/Superfoods-Table.csv'
CSV.foreach(filepath, {col_sep: ';'}) do |row|
  puts "#{row}"
  Ingredient.where(name: row[0].downcase.tr(' ', '_')).update_all(superfood: true)
end

filepath = 'seed_assets/smoothies_data_oct_11/Badges-Table.csv'
CSV.foreach(filepath, {col_sep: ';'}) do |row|
  puts "#{row}"
  Badge.create!(name: row[0].downcase.tr(' ', '_'), image: row[1])
end

filepath = 'seed_assets/smoothies_data_oct_11/Smoothies-Table.csv'
Size.all.each do |size|
  CSV.foreach(filepath, {col_sep: ';'}) do |row|
    puts "#{size.name} - #{row}"

    smoothie = Smoothie.new(
      name: row[0].downcase.tr(' ', '_'),
      group_id: Group.find_by(name: row[1]).id,
      size_id: size.id,
      number: row[2].to_i,
      description: row[3],
      great_with: row[4],
      ingredient_description: row[5],
      story: row[6],
      benefits_one: row[7],
      benefits_two: row[8],
      benefits_three: row[9],
      when: row[10],
      contains: row[11],
      superfood: row[12].downcase.tr(' ', '_'),
      logo: row[47])

    if true && smoothie_image_strings.include?(row[46])
      smoothie_images_count += 1
      if Rails.env.production?
        smoothie.remote_photo_url = remote_photo_url = Rails.root.join('seed_assets', 'smoothie_images_oct_11', row[46]).to_s
      else
        smoothie.image = row[46]
      end
    end
    smoothie.save!

    NutriInfo.create!(
      smoothie_id: smoothie.id,
      energy_kJ: row[13].to_f,
      energy_kcal: row[14].to_f,
      fat_g: row[15].to_f,
      fat_saturates_g: row[16].to_f,
      carbs_g: row[17].to_f,
      carbs_sugars_g: row[18].to_f,
      fibre_g: row[19].to_f,
      protein_g: row[20].to_f,
      salt_g: row[21].to_f,
      protein_percentage: row[48].to_i,
      carbs_percentage: row[49].to_i,
      fat_percentage: row[50].to_i)

    # Create ingredients for each smoothie
    unless row[22].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[22].downcase.tr(' ', '_')).id,
        large: true, special: false)
    end

    unless row[23].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[23].downcase.tr(' ', '_')).id,
        large: true, special: false)
    end

    unless row[24].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[24].downcase.tr(' ', '_')).id,
        large: true, special: false)
    end

    unless row[25].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[25].downcase.tr(' ', '_')).id,
        large: true, special: false)
    end

    unless row[26].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[26].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end


    unless row[27].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[27].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[28].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[28].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[29].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[29].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[30].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[30].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[31].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[31].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[32].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[32].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[33].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[33].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[34].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[34].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[35].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[35].downcase.tr(' ', '_')).id,
        large: false, special: false)
    end

    unless row[36].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[36].downcase.tr(' ', '_')).id,
        large: false, special: true)
    end

    unless row[37].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[37].downcase.tr(' ', '_')).id,
        large: false, special: true)
    end

    unless row[38].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[38].downcase.tr(' ', '_')).id,
        large: false, special: true)
    end

    unless row[39].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[39].downcase.tr(' ', '_')).id,
        large: false, special: true)
    end

    unless row[40].nil?
      SmoothieIngredient.create!(
        smoothie_id: smoothie.id,
        ingredient_id: Ingredient.find_by(name: row[40].downcase.tr(' ', '_')).id,
        large: false, special: true)
    end

    # Special ingredient #6 - if exists it is "lo_carb"
    # However, there is no ingredient called "lo carb" in the database.
    # unless row[41].nil?
    #   SmoothieIngredient.create!(
    #     smoothie_id: smoothie.id,
    #     ingredient_id: Ingredient.find_by(name: row[41].downcase.tr(' ', '_')).id,
    #     large: false, special: true)
    # end

    # Create badges for each smoothie
    unless row[42].nil?
      SmoothieBadge.create!(
        smoothie_id: smoothie.id,
        badge_id: Badge.find_by(name: row[42].downcase.tr(' ', '_')).id)
    end

    unless row[43].nil?
      SmoothieBadge.create!(
        smoothie_id: smoothie.id,
        badge_id: Badge.find_by(name: row[43].downcase.tr(' ', '_')).id)
    end

    unless row[44].nil?
      SmoothieBadge.create!(
        smoothie_id: smoothie.id,
        badge_id: Badge.find_by(name: row[44].downcase.tr(' ', '_')).id)
    end

    unless row[45].nil?
      SmoothieBadge.create!(
        smoothie_id: smoothie.id,
        badge_id: Badge.find_by(name: row[45].downcase.tr(' ', '_')).id)
    end

  end
end

puts "================="
puts "smoothie images: #{smoothie_images_count} created vs #{smoothie_image_strings.count} exist"
puts "ingredient images: #{ingredient_images_count} created vs #{ingredient_image_strings.count} exist"
