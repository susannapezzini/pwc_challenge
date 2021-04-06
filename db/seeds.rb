# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'


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

def get_bank(bank_name)
  Bank.find_by(name: bank_name)
end

def get_product(product_name)
  Product.find_by(name: product_name)
end

# puts 'Creating seeds'
admin_user = User.create(name:'Pedro Santos', email: 'hello@mail.com', password: '123456', admin: true)
default_user = User.create(name:'João Viana', email: 'sad@mail.com', password: '123456', bank: get_bank("abanca"))
puts "users created"




csv_options = { headers:true, col_sep: ';', header_converters: :symbol, encoding:'iso-8859-1:utf-8'}
csv_text = File.read(Rails.root.join('lib', 'seeds', 'banks.csv'))
#id;bp_bank_id;name;address;country
CSV.foreach("lib/seeds/banks.csv", csv_options) do |row|
  Bank.create!(row)
end

#id;bank_id;url;description
CSV.foreach("lib/seeds/websites.csv", csv_options) do |row|
  website = Website.new(row)
  website.bank = get_bank(row[:bank_id])
  website.save!
end
puts "websites created"

Request.create
puts "request created"
abanca_doc = Document.create!(request_id: Request.first.id, bank_id: get_bank("abanca").id)
banco_bai_doc = Document.create!(request_id: Request.first.id, bank_id: get_bank("banco bai").id)


demand_deposit = Product.create!(name: "Demand Deposits")
term_deposit = Product.create!(name: "Term Deposits")
housing_credit = Product.create!(name: "Housing Credit")
puts "products created"

# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Private Demand Deposit Account (Avg Balance <1000€)", search_name: "3.1 Conta D.O. Particulares (Nota 2) ")


# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Private Demand Deposit Account (Avg Balance <1000-2500€)", search_name: "3.1 Conta D.O. Particulares (Nota 2) ")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Private Demand Deposit Account (Balance >2500€", search_name: "3.1 Conta D.O. Particulares (Nota 2) ")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Bank Account with Direct Deposit Enabled", search_name: "3.2 Conta Ordenado")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Standard Account (doesn't admit new hirings)", search_name: "3.3 Conta Standard (não admite novas contratações)")

  
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Future Account", search_name: "3.4 Conta Future (Nota 3)")

  
  
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: " Kids Account", search_name: "3.5 Conta Kids (Nota 4)")
  
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Global Account", search_name: "3.6 Conta Global (Nota 5")
  
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Basic Account", search_name: "3.7 Conta Base (Nota 6)")
  
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Private Account", search_name: "3.8 Conta Private (Nota 7)")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Value Account", search_name: "3.9 Conta Value (Nota 8)")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Smart Account", search_name: "3.10 Conta Smart (Nota 9)")
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "Minimal Bank Services Account", search_name: "3.12 Conta Serviços Mínimos Bancários (Nota 11)")
# Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
#   name: "ABANCA International Account", search_name: "3.14 Conta ABANCA Internacional (Nota 17)")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
#   name: "Bank Account CTT", search_name: "Conta Banco CTT)")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
#   name: "Junior Account", search_name: "Conta Júnior (Montante Mínimo de Abertura 25,00€)")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
#   name: "Conta Base", search_name: "Conta Base")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
#   name: "Bank Account with Minimum Services", search_name: "Conta de Serviços Mínimos Bancários")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_bai.id, 
#   name: "Demand Deposits Account", search_name: "Conta Depósito à Ordem (EUR/ Moeda Estrangeira)")

# Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_bai.id, 
#   name: "Demand Deposits Account", search_name: "Conta de Serviços Mínimos Bancários")

# Subproduct.create!(product_id: term_deposit.id, bank_id: bank_inter.id, 
#   name: "Test Product 123", search_name: "")

# Subproduct.create!(product_id: housing_credit.id, bank_id: banco_bic.id, 
#   name: "Test Product 456", search_name: "")

# Subproduct.create!(product_id: housing_credit.id, bank_id: banco_ctt.id, 
#   name: "Test Product XYZ", search_name: "")

# puts "subproducts created"

# # Abanca Demand Deposit Fees
# Fee.create!(product_id: demand_deposit.id, name: "Account Management Fees", 
#   search_name: "3. Manutenção de conta", category: "Fixed")

#   abanca.subproducts.where(product_id: demand_deposit.id).each do |s|
#     Price.create!(fee_id: Fee.last.id, subproduct_id: s.id, amount: 5, document_id: banco_bai_doc.id)
#   end

# Fee.create!(product_id: demand_deposit.id, name: "Monthly Statement Fee", 
#   search_name: "1.1 Mensal (enviado ao domicílio)", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Other requests besides monthly statement", 
#   search_name: "1.2 Outros, para além do indicado em 1.1", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Statement replacement", 
#   search_name: "1.3 2ª Via", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Additional copy of deposit receipt", 
#   search_name: "2. Fotocópias de segundas vias de talões de depósito", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Depositing a check to receive cash", 
#   search_name: "4.1 Ao balcão, com apresentação de cheque", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "At the counter without check presentation", 
#   search_name: "4.2 Ao balcão, sem apresentação de cheque", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Remote Bank Service Adherence/Online-Mobile Banking", 
#   search_name: "5. Adesão ao serviço de banca à distância", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Deposit of metal coins (at least 100 coins per day per account)", 
#   search_name: "6. Depósito de moedas metálicas (igual ou superior a 100 moedas por dia e por conta)", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Account Owners Change", 
#   search_name: "7. Alteração de titulares", category: "Optional")
#   add_last_fee_to_all_subproducts_of(abanca, demand_deposit)

# # Banco CTT Demand Deposit Fees

# Fee.create!(product_id: demand_deposit.id, name: "Commission for account maintenance", 
#   search_name: "4.Comissão de manutenção de conta", category: "Optional")
#   add_last_fee_to_all_subproducts_of(banco_ctt, demand_deposit)

# # Banco Bai Demand Deposit Fees  "
# Fee.create!(product_id: demand_deposit.id, name: "Account Management Fee", 
#   search_name: "1. Manutenção de conta", category: "Optional")
#   add_last_fee_to_all_subproducts_of(banco_bai, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Integrated Statement", 
#   search_name: "4. Extracto integrado", category: "Optional")
#   add_last_fee_to_all_subproducts_of(banco_bai, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Cash Withdrawal", 
#   search_name: "2. Levantamento de numerário", category: "Optional")
#   add_last_fee_to_all_subproducts_of(banco_bai, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "USD withdrawal in USD accounts", 
#   search_name: "3. Levantamento USD em contas USD", category: "Optional")
#   add_last_fee_to_all_subproducts_of(banco_bai, demand_deposit)

# Fee.create!(product_id: demand_deposit.id, name: "Single Statement", 
#   search_name: "5. Extracto avulso", category: "Optional")
#   add_last_fee_to_all_subproducts_of(banco_bai, demand_deposit)

# puts 'done'

# banco_ctt = Bank.create(
#   name: 'banco ctt',
#   address: 'Av. Dom João II 13, 1999-001 Lisboa',
#   country: 'Portugal',
#   websites_attributes: [
#   { 
#     url: "https://www.bancoctt.pt"
#   }])

# abanca = Bank.create(
#   name: 'abanca',
#   address: 'Rua Castilho, n.º 20, 1250-069, Lisboa',
#   country: 'Portugal',
#   websites_attributes: [
#   { 
#     url: "https://www.bancoctt.pt"
#   }])

# banco_bai = Bank.create(
#   name: 'banco bai europa',
#   address: 'Rua Tierno Galvan Torre 3, 12º Piso, 1070-274 Lisboa',
#   country: 'Portugal',
#   websites_attributes: [
#   { 
#     url: "https://www.bancobaieuropa.pt"
#   }])

# banco_bic = Bank.create(
#   name: 'banco bic',
#   address: 'Avenida Antonio Augusto De Aguiar, N.º 132',
#   country: 'Portugal',
#   websites_attributes: [
#   { 
#     url: "https://www.eurobic.pt"
#   }])

# bank_inter = Bank.create(
#   name: 'bankinter',
#   address: 'Praça Marquês de Pombal, n.º 13, 2.º Andar, 1250-162 Lisboa',
#   country: 'Portugal',
#   websites_attributes: [
#   { 
#     url: "https://www.bankinter.pt"
#   },
#   {
#     url:"https://www.bankinter.com"
#   }])

# # # BANKS.each do |bank|
# # #   bank = Bank.create(bank)

# #   # # adding products to the banks
# #   # pdf_sections1 = { sections: ['1.1', '17.1'] }
# #   # demand_deposits = Product.create(
# #   #             name: 'Demand deposits',
# #   #             pdf_sections: pdf_sections1,
# #   #             product_family: product_family,
# #   #             bank: bank)
# #   # pdf_sections2 = { sections: ['17.2'] }
# #   # term_deposits = Product.create(
# #   #             name: 'Term deposits',
# #   #             pdf_sections: pdf_sections2,
# #   #             product_family: product_family,
# #   #             bank: bank)
# #   # pdf_sections3 = { sections: ['2.1', '18.1'] }
# #   # housing_credit = Product.create(
# #   #             name: 'Housing credit',
# #   #             pdf_sections: pdf_sections3,
# #   #             product_family: product_family,
# #   #             bank: bank)
# # # end