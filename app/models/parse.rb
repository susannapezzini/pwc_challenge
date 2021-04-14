
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

t[:"1"][:products][:demand_deposit].each do |category_name, fees|
  fees.each do |fee|
    #puts "Category #{category_name} #{fee}"
    Fee.create!(name: fee, category: category_name)
  end
end