# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'creating seeds'

sub = Subscription.create(price: 5)
you = User.create(first_name: 'thales', email: 'hello@mail.com', password: '123456', subscription: sub)
bank = Bank.create(name: 'Banco CTT', subscription: sub)
family = ProductFamily.create(name: 'deposits')
product = Product.create(name: 'Spongebob', product_family: family)
bank_product = BankProduct.create(bank: bank, product: product)
3.times do
  Price.create(price: rand(0..100), bank_product: bank_product)
end

puts 'done motehfucker'
