# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying all seeds..."

Document.destroy_all
Price.destroy_all
Fee.destroy_all
Product.destroy_all
Request.destroy_all
Subproduct.destroy_all
Website.destroy_all
Bank.destroy_all
User.destroy_all

puts 'Creating seeds'

admin_user = User.create(name:'Pedro Santos', email: 'hello@mail.com', password: '123456', admin: true)
default_user = User.create(name:'João Viana', email: 'sad@mail.com', password: '123456')
puts "users created"

BANKS = [{
    name: 'banco ctt',
    address: 'Av. Dom João II 13, 1999-001 Lisboa',
    country: 'Portugal'
  },
  {
    name: 'abanca',
    address: 'Rua Castilho, n.º 20, 1250-069, Lisboa',
    country: 'Portugal'
  },
  {
    name: 'banco bai europa',
    address: 'Rua Tierno Galvan Torre 3, 12º Piso, 1070-274 Lisboa',
    country: 'Portugal'
  },
  {
    name: 'banco bic',
    address: 'Avenida Antonio Augusto De Aguiar, N.º 132',
    country: 'Portugal'
  },
  {
    name: 'bankinter',
    address: 'Praça Marquês de Pombal, n.º 13, 2.º Andar, 1250-162 Lisboa',
    country: 'Portugal'
  }
]
banco_ctt = Bank.create!(BANKS[0])
abanca = Bank.create!(BANKS[1])
banco_bai = Bank.create!(BANKS[2])
banco_bic = Bank.create!(BANKS[3])
bankinter = Bank.create!(BANKS[4])
puts "banks created"

Website.create!(url: "https://www.bancoctt.pt", bank_id: banco_ctt.id)
Website.create!(url: "https://www.bancobaieuropa.pt", bank_id: banco_bai.id)
Website.create!(url: "https://www.eurobic.pt", bank_id: banco_bic.id)
Website.create!(url: "https://www.bankinter.pt", bank_id: bankinter.id)
Website.create!(url: "https://www.bankinter.com", bank_id: bankinter.id)
Website.create!(url: "https://www.abanca.pt", bank_id: abanca.id)
puts "websites created"



demand_deposit = Product.create!(name: "Demand Deposits")
term_deposit = Product.create!(name: "Term Deposits")
housing_credit = Product.create!(name: "Housing Credit")
puts "products created"

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Private Demand Deposit Account (Avg Balance <1000€)", search_name: "3.1 Conta D.O. Particulares (Nota 2) ")

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Private Demand Deposit Account (Avg Balance <1000-2500€)", search_name: "3.1 Conta D.O. Particulares (Nota 2) ")

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Private Demand Deposit Account (Balance >2500€", search_name: "3.1 Conta D.O. Particulares (Nota 2) ")

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Bank Account with Direct Deposit Enabled", search_name: "3.2 Conta Ordenado")

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Standard Account (doesn't admit new hirings)", search_name: "3.3 Conta Standard (não admite novas contratações)")

  
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Future Account", search_name: "3.4 Conta Future (Nota 3)")
  
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: " Kids Account", search_name: "3.5 Conta Kids (Nota 4)")
  
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Global Account", search_name: "3.6 Conta Global (Nota 5")
  
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Basic Account", search_name: "3.7 Conta Base (Nota 6)")
  
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Private Account", search_name: "3.8 Conta Private (Nota 7)")

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Value Account", search_name: "3.9 Conta Value (Nota 8)")

Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Smart Account", search_name: "3.10 Conta Smart (Nota 9)")
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "Minimal Bank Services Account", search_name: "3.12 Conta Serviços Mínimos Bancários (Nota 11)")
Subproduct.create!(product_id: demand_deposit.id, bank_id: abanca.id, 
  name: "ABANCA International Account", search_name: "3.14 Conta ABANCA Internacional (Nota 17)")

Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
  name: "Bank Account CTT", search_name: "Conta Banco CTT)")

Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
  name: "Junior Account", search_name: "Conta Júnior (Montante Mínimo de Abertura 25,00€)")

Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
  name: "Conta Base", search_name: "Conta Base")

Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_ctt.id, 
  name: "Bank Account with Minimum Services", search_name: "Conta de Serviços Mínimos Bancários")

Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_bai.id, 
  name: "Demand Deposits Account", search_name: "Conta Depósito à Ordem (EUR/ Moeda Estrangeira)")

Subproduct.create!(product_id: demand_deposit.id, bank_id: banco_bai.id, 
  name: "Demand Deposits Account", search_name: "Conta de Serviços Mínimos Bancários")

Subproduct.create!(product_id: term_deposit.id, bank_id: bankinter.id, 
  name: "Test Product 123", search_name: "")

Subproduct.create!(product_id: housing_credit.id, bank_id: banco_bic.id, 
  name: "Test Product 456", search_name: "")

Subproduct.create!(product_id: housing_credit.id, bank_id: banco_ctt.id, 
  name: "Test Product XYZ", search_name: "")

puts "subproducts created"

Fee.create!(product_id: demand_deposit.id, name: "Account Management Fees", 
  search_name: "3. Manutenção de conta", category: "Fixed")


Fee.create!(product_id: demand_deposit.id, name: "Monthly Statement Fee", 
  search_name: "1.1 Mensal (enviado ao domicílio)", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Other requests besides monthly statement", 
  search_name: "1.2 Outros, para além do indicado em 1.1", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Statement replacement", 
  search_name: "1.3 2ª Via", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Additional copy of deposit receipt", 
  search_name: "2. Fotocópias de segundas vias de talões de depósito", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Depositing a check to receive cash", 
  search_name: "4.1 Ao balcão, com apresentação de cheque", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "At the counter without check presentation", 
  search_name: "4.2 Ao balcão, sem apresentação de cheque", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Remote Bank Service Adherence/Online-Mobile Banking", 
  search_name: "5. Adesão ao serviço de banca à distância", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Deposit of metal coins (at least 100 coins per day per account)", 
  search_name: "6. Depósito de moedas metálicas (igual ou superior a 100 moedas por dia e por conta)", category: "Optional")

Fee.create!(product_id: demand_deposit.id, name: "Account Owners Change", 
  search_name: "7. Alteração de titulares", category: "Optional")

puts 'done'



# BANKS.each do |bank|
#   bank = Bank.create(bank)

  # # adding products to the banks
  # pdf_sections1 = { sections: ['1.1', '17.1'] }
  # demand_deposits = Product.create(
  #             name: 'Demand deposits',
  #             pdf_sections: pdf_sections1,
  #             product_family: product_family,
  #             bank: bank)
  # pdf_sections2 = { sections: ['17.2'] }
  # term_deposits = Product.create(
  #             name: 'Term deposits',
  #             pdf_sections: pdf_sections2,
  #             product_family: product_family,
  #             bank: bank)
  # pdf_sections3 = { sections: ['2.1', '18.1'] }
  # housing_credit = Product.create(
  #             name: 'Housing credit',
  #             pdf_sections: pdf_sections3,
  #             product_family: product_family,
  #             bank: bank)
# end