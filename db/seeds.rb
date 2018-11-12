# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

# 10.times do |i|
#   @store = Store.create(name: "tienda#{i + 1}", rut: '12345678')
#   10.times do |j|
#     Product.create(
#                   name: "producto#{j + 1}",
#                   description: 'papa fritas',
#                   image:"image_tag shawarma",
#                   price: 2000,
#                   store_id: @store.id
#     )
#   end
# end
addresses = "289 Constitution Court
Liverpool, NY 13090
8248 Buttonwood Drive
Herndon, VA 20170
953 Lake View Lane
Greensburg, PA 15601
8489 Smith Store Street
Wake Forest, NC 27587
60 Pumpkin Hill Dr.
South Ozone Park, NY 11420
923 Wakehurst Lane
New Orleans, LA 70115
995 Lakewood Court
Upland, CA 91784"

Store.destroy_all
addresses = addresses.split("\n")
addresses.each do |address|
  @store = Store.create!(name: Faker::Name.name, address: address, rut: '12345678', image: Faker::Company.logo, )
  sleep 1
  10.times do |j|
      Product.create(
                    name: Faker::Food.dish,
                    description: Faker::Food.description,
                    image: Faker::Company.logo,
                    price: 2000,
                    store_id: @store.id
     )
   end
end
