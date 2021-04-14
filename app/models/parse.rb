
t = {
    "1": {
        "url": "www.abanca.pt",
        "bp_pdf_url": "https://clientebancario.bportugal.pt/sites/default/files/precario/0170_/0170_PRE.pdf",
        "bp_bank_id": "0170",
        "cloud_merged_url": "https://storage.googleapis.com/bank_price_pdfs/1_all_products_210412130040.pdf",
        "products": {"demand_deposit":
                {
                    "statement": [
                    "Emissão de extrato",
                    "Extrato Integrado",
                    "Extrato Mensal",
                    "Extrato integrado",
                    "Extrato avulso"
                ],
                "documents_copy": [
                    "Fotocópias de segundas vias de talões de depósito",
                    "Emissão 2ªs Vias de Avisos e Outros Documentos",
                    "Extracto avulso",
                    "Segundas vias (pedido na agência)"
                ],
                "acc_manteinance": [
                    "Manutenção de conta",
                    "Comissão de manutenção de conta",
                    "Comissão de Manutenção de Conta",
                    "Manutenção de Conta Pacote",
                    "Manutenção de Conta Base",
                    "Manutenção de Conta Serviços Mínimos Bancários"
                ],
                "withdraw": [
                    "Levantamento de numerário",
                    "Levantamento de numerário ao balcão",
                    "Comissão de Levantamento",
                    "Levantamento de Numerário ao Balcão",
                    "Levantamento de Numerário ao Balcão"
                ],
                "online_service": [
                    "Adesão ao serviço de banca à distância",
                    "Adesão ao serviço online"
                ],
                "cash_deposit": [
                    "Depósito de moedas metálicas",
                    "Depósito de moedas",
                    " Depósito em moeda metálica (>= 100 moedas)",
                    "Depósito de moedas ao balcão",
                    "Depósito de dinheiro ao balcão",
                    "Depósito em moeda metálica (>= 100 moedas)"
                ],
                "change_holder": [
                    "Alteração de titulares",
                    "Alteração de titularidade",
                    "Comissão de Alteração de Titularidade",
                    "Alteração de titularidade / intervenientes",
                    "Alteração de titularidade (titular/ representante)"
                ],
                "bank_overdraft": [
                    "Comissões por descoberto bancário",
                    "Descoberto bancário",
                    "Comissões por Descoberto Bancário"
                ],
                "movement_consultation": [
                    "Consulta de Movimentos de conta DO com",
                    "Consulta de movimentos ao balcão"
                ],
                "balance_inquiry": [
                    "Pedido de saldo ao balcão",
                    "Consulta de Saldo de conta DO com comprovativo"
                ],
                #"portuguese": "Contas de Depósito"
            }
        }
    }
}

# t[:"1"][:products][:demand_deposit].each do |category_name, fees|
#   fees.each do |fee|
#     #puts "Category #{category_name} #{fee}"
#     Fee.create!(name: fee, category: category_name)
#   end
# end


abanca_hash = {
  "1": {
    "products": {
      "demand_deposit": {
        "subproducts": {
          "Conta D.O.": {
            "acc_manteinance": "15,00"
          },
          "Conta Ordenado": {
            "acc_manteinance": "0,00"
          },
          "Conta Standard": {
            "acc_manteinance": "0,00"
          },
          "Conta Future": {
            "acc_manteinance": "0,00"
          },
          "Conta Kids": {
            "acc_manteinance": "0,00"
          },
          "Conta Base": {
            "acc_manteinance": "10,00"
          },
          "Conta Private": {
            "acc_manteinance": "8,00"
          },
          "Conta Value": {
            "acc_manteinance": "5,00"
          },
          "Conta Smart": {
            "acc_manteinance": "5,00"
          },
          "Conta Futuro": {
            "acc_manteinance": "0,00"
          },
          "Conta Moeda Estrangeira e": {
            "acc_manteinance": "15,00"
          },
          "Conta ABANCA Internacional.": {
            "acc_manteinance": "15,00"
          },
          "Conta para clientes dos 18 aos 28 anos.": {
            "acc_manteinance": "0,23"
          },
          "Conta para clientes dos 0 aos 17 anos.": {
            "acc_manteinance": "0,23"
          },
          "General": {
            "statement": "0,00",
            "documents_copy": "5,00",
            "acc_manteinance": "10,00",
            "withdraw": "0,00",
            "online_service": "0,00",
            "cash_deposit": "3,50",
            "change_holder": "5,00"
          }
        },
        "n_subproducts": 14
      }
    },
    "housing_credit": {
      "commissions": {
        "subproduct1": {
          "commission1": "123",
          "commission2": "345"
        },
        "subproduct2": {
          "commission1": "123",
          "commission2": "345"
        }
      }
    }
  }
}

abanca = Bank.find_by(name: "ABANCA")
current_request = Request.create(name: "Manual Request")
current_doc = Document.create(bank_id: abanca.id, request_id: current_request.id)

abanca_hash[:"1"][:products][:demand_deposit][:subproducts].each do |subproduct, fee_price|
  dd = Product.find_by(name: "Demand Deposits")
  unless current_sub = Subproduct.find_by(name: subproduct)
    p current_sub = Subproduct.create!(bank_id: abanca.id, product_id: dd.id, name: subproduct)
  end

  fee_price do |fee, price|
    unless current_fee = Fee.find_by(name: fee)
      current_fee = Fee.create!(product_id: dd.id, name: fee)
    end

    p Price.create!(fee_id: fee.id, subproduct_id: current_sub.id, document_id: current_doc.id)
  end
end