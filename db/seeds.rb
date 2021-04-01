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
    address: 'Av. Dom João II 13, 1999-001 Lisboa',
    country: 'portugal'
  },
  {
    name: 'abanca',
    address: 'Rua Castilho, n.º 20, 1250-069, Lisboa',
    country: 'portugal'
  },
  {
    name: 'banco bai europa',
    address: 'Rua Tierno Galvan Torre 3, 12º Piso, 1070-274 Lisboa',
    country: 'portugal'
  },
  {
    name: 'banco bic',
    address: 'AVENIDA ANTÓNIO AUGUSTO DE AGUIAR, N.º 132',
    country: 'portugal'
  },
  {
    name: 'bankinter',
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

Website.create(url: "https://www.bancoctt.pt", bank_id: Bank.where(name: "banco ctt").first.id)
Website.create(url: "https://www.bancobaieuropa.pt", bank_id: Bank.where(name: "banco bai europa").first.id)
Website.create(url: "https://www.eurobic.pt", bank_id: Bank.where(name: "banco bic").first.id)
Website.create(url: "https://www.bankinter.pt", bank_id: Bank.where(name: "bankinter").first.id)
Website.create(url: "https://www.bankinter.com", bank_id: Bank.where(name: "bankinter").first.id)
puts 'done'
