# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |user|
    User.create(
        email: "test#{user + 1}@test.com",
        password: "password"
    )
    4.times do |listing|
        User.last.listings.create(
            title: "Listing #{listing}",
            description: "I'm baby ut celiac meh tempor. Kickstarter 8-bit cupidatat actually. Waistcoat tattooed in occaecat, taxidermy williamsburg taiyaki cray bitters migas art party keffiyeh excepteur lo-fi snackwave. Ut 3 wolf moon chillwave, succulents taxidermy you probably haven't heard of them keytar tbh viral whatever. Put a bird on it adaptogen nisi live-edge yr. Dolor mlkshk +1 gentrify air plant cray dolore. Cardigan coloring book distillery portland est photo booth viral etsy ipsum adaptogen cold-pressed cornhole roof party.",
            price: rand(120)
        )
    end
end

