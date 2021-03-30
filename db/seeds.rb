# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying all seeds..."
Pricing.destroy_all
Product.destroy_all
ProductFamily.destroy_all
Bank.destroy_all
User.destroy_all

puts 'Creating seeds'

BANKS = [{
    name: 'banco ctt',
    website: 'https://www.bancoctt.pt',
    address: 'Av. Dom João II 13, 1999-001 Lisboa',
    country: 'portugal'
  },
  {
    name: 'abanca',
    website: 'https://www.abanca.pt',
    address: 'Rua Castilho, n.º 20, 1250-069, Lisboa',
    country: 'portugal'
  },
  {
    name: 'banco bai europa',
    website: 'https://www.bancobaieuropa.pt',
    address: 'Rua Tierno Galvan Torre 3, 12º Piso, 1070-274 Lisboa',
    country: 'portugal'
  },
  {
    name: 'banco bic',
    website: 'https://www.eurobic.pt',
    address: 'AVENIDA ANTÓNIO AUGUSTO DE AGUIAR, N.º 132',
    country: 'portugal'
  },
  {
    name: 'bankinter',
    website: 'https://www.bankinter.pt',
    address: 'Praça Marquês de Pombal, n.º 13, 2.º Andar, 1250-162 Lisboa',
    country: 'portugal'
  }
]

admin_user = User.create(name:'Pedro Santos', email: 'hello@mail.com', password: '123456', admin: true)
default_user = User.create(name:'João Viana', email: 'sad@mail.com', password: '123456')

product_family = ProductFamily.create(name: 'product')
service_family = ProductFamily.create(name: 'service')

BANKS.each do |bank|
  bank = Bank.create(bank)

  # adding products to the banks
  pdf_sections1 = { sections: ['1.1', '17.1'] }
  demand_deposits = Product.create(
              name: 'Demand deposits',
              pdf_sections: pdf_sections1,
              product_family: product_family,
              bank: bank)
  pdf_sections2 = { sections: ['17.2'] }
  term_deposits = Product.create(
              name: 'Term deposits',
              pdf_sections: pdf_sections2,
              product_family: product_family,
              bank: bank)
  pdf_sections3 = { sections: ['2.1', '18.1'] }
  housing_credit = Product.create(
              name: 'Housing credit',
              pdf_sections: pdf_sections3,
              product_family: product_family,
              bank: bank)
end

puts 'done motehfucker'
