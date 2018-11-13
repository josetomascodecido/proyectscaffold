# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

10.times do |i|
  @store = Store.create(name: "tienda#{i + 1}", rut: '12345678')
  10.times do |j|
    Product.create(
                  name: "producto#{j + 1}",
                  description: 'papa fritas',
                  image: File.open('shawarma.jpg'),
                  price: 2000,
                  store_id: @store.id
    )
  end
end
