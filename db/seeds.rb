# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'
status = %w[pending active]

puts "Destroying all seeds..."
Price.destroy_all
Fee.destroy_all
Website.destroy_all
Document.destroy_all
Product.destroy_all
Subproduct.destroy_all
Request.destroy_all
Bank.destroy_all
User.destroy_all
Group.destroy_all

#helper methods
def get_bank(bank_name)
  Bank.find_by(name: bank_name)
end

def get_product(product_name)
  Product.find_by(name: product_name)
end

def get_subproduct(name)
  Subproduct.find_by(name: name) # in case there are subproudcts with more than one name
end

def get_fee(fee_name)
  Fee.find_by(name: fee_name)
end

def get_group(name)
  Group.find_by(name: name)
end
# puts 'Creating seeds'

csv_options = { headers:true, col_sep: ';', header_converters: :symbol, encoding:'utf-8'}

csv_text = File.read(Rails.root.join('lib', 'seeds', 'banks.csv'))
#id;bp_bank_id;name;address;country
CSV.foreach("lib/seeds/banks.csv", csv_options) do |row|
  Bank.create!(row)
end

admin_user = User.create(name:'Pedro Santos', email: 'hello@mail.com', password: '123456', admin: true)
default_user = User.create(name:'João Viana', email: 'sad@mail.com', password: '123456', bank: get_bank("abanca"))

User.create(name:'João Viana', email: 'sad@mail.com', password: '123456', bank: get_bank("abanca"))
User.create(name:'Cristiano Ronaldo', email: 'ronaldo@abanca.pt', password: '123456', bank: get_bank("abanca"))
User.create(name:'Fernando Pessoa', email: 'fernando@bancoctt.pt', password: '123456', bank: get_bank("banco ctt"))
User.create(name:'Salvador Sobral', email: 'salvador@bankinter.pt', password: '123456', bank: get_bank("bankinter"))
User.create(name:'Luis de Camões', email: 'luis@bancobai.pt', password: '123456', bank: get_bank("banco bai"))
User.create(name:'Luis Figo', email: 'luis@bancobic.pt', password: '123456', bank: get_bank("banco bic"))
User.create(name:'Pedro Agostinho', email: 'pedro@pwc.com', password: '123456', admin: true)
User.create(name:'Diogo André Vieira', email: 'diogo@pwc.com', password: '123456', admin: true)
User.create(name:'Gonçalo Catarino Monteiro', email: 'gonçalo@pwc.com', password: '123456', admin: true)
User.create(name:'Afonso Dias Coelho', email: 'alfonso@pwc.com', password: '123456', admin: true)

puts "users created"
puts 'creating requests'
10.times do
  Request.create(content: 'I am a request and I am supposed to provide useful content', status: status.sample)
end

#id;bank_id;url;description
CSV.foreach("lib/seeds/websites.csv", csv_options) do |row|
  website = Website.new(row)
  website.bank = get_bank(row[:bank_id])
  website.save!
  end
puts "websites created"

abanca_doc = Document.create!(request: Request.all.sample, bank_id: get_bank("abanca").id)
banco_bai_doc = Document.create!(request: Request.all.sample, bank_id: get_bank("banco bai").id)



demand_deposit = Product.create!(name: "Demand Deposits")
term_deposit = Product.create!(name: "Term Deposits")
housing_credit = Product.create!(name: "Housing Credit")
puts "products created"

#id;product_id;name;search_name;category
CSV.foreach("lib/seeds/fees.csv", csv_options) do |row|
  fee = Fee.new(row)
  fee.product = get_product(row[:product_id])
  fee.save!
end
puts "fees created"


CSV.foreach("lib/seeds/groups.csv", csv_options) do |row|
  Group.create!(row)
end
puts "groups created"

#id;product_id;bank_id;name;search_name
CSV.foreach("lib/seeds/subproducts.csv", csv_options) do |row|
  subproduct = Subproduct.new(row)
  subproduct.product = get_product(row[:product_id])
  subproduct.bank = get_bank(row[:bank_id])
  if row[:group_id].present?
    subproduct.group = get_group(row[:group_id])
  end
  subproduct.save!

end
puts "subproducts created"

# i = 0
#id;fee_id;subproduct_id;document_id;name;amount;category;tax;tax_amount;tax_category;status
CSV.foreach("lib/seeds/prices.csv", csv_options) do |row|
  # puts i to find error in seeds
  # i += 1
  price = Price.new(row)
  price.subproduct = get_subproduct(row[:subproduct_id])
  price.fee = get_fee(row[:fee_id])
  price.document = Document.all.sample
  price.save!
end
puts "prices created"


puts "updating bank names"
 Bank.find_by(name: "banco ctt").update(name: "Banco CTT")
 Bank.find_by(name: "abanca").update(name: "ABANCA")
 Bank.find_by(name: "banco bai").update(name: "Banco BAI")
 Bank.find_by(name: "banco bic").update(name: "Banco BIC")
 Bank.find_by(name: "bankinter").update(name: "Bankinter")


puts 'done'


# # BANKS.each do |bank|
# #   bank = Bank.create(bank)

#   # # adding products to the banks
#   # pdf_sections1 = { sections: ['1.1', '17.1'] }
#   # demand_deposits = Product.create(
#   #             name: 'Demand deposits',
#   #             pdf_sections: pdf_sections1,
#   #             product_family: product_family,
#   #             bank: bank)
#   # pdf_sections2 = { sections: ['17.2'] }
#   # term_deposits = Product.create(
#   #             name: 'Term deposits',
#   #             pdf_sections: pdf_sections2,
#   #             product_family: product_family,
#   #             bank: bank)
#   # pdf_sections3 = { sections: ['2.1', '18.1'] }
#   # housing_credit = Product.create(
#   #             name: 'Housing credit',
#   #             pdf_sections: pdf_sections3,
#   #             product_family: product_family,
#   #             bank: bank)
# # end