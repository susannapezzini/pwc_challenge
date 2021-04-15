require 'open-uri'
require 'net/http'
require 'json'
class ProductUpdateJob < ApplicationJob
  queue_as :default

  def perform(bank_id,bp_bank_id, bp_pdf_url, prod_type, cloud_merged_url)
    product = ''
    if (prod_type.downcase == 'demand deposits')
      product = @@demand_deposits
    elsif (prod_type.downcase == 'housing credits')
      product = @@house_credit_com
    end
    @bank = Bank.find(bank_id)
    @payload = {
      "#{@bank.id}": {
        "url": @bank.websites.first.url,
        "bp_pdf_url": bp_pdf_url,
        "bp_bank_id": bp_bank_id,
        "cloud_merged_url": cloud_merged_url,
        "products": product
      }  
    }
    @result = HTTParty.post('https://bank-price-api.herokuapp.com/get_stats', 
      :body => @payload.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    if @result['status'] == 'ok'
      @data = retrieve_stats(@result['ident'])
      count = 0
      while @data['status'] == 'error' 
        sleep 1
        @data = retrieve_stats(@result['ident'])
        count += 1
        break if count == 100
        puts "Try #{count} times"
        byebug
      end
      # @pdfs =  @data.values[0]["list_pdfs"]["urls"]
      # @merged_pdfs = @data.values[0]["list_pdfs"]["cloud_merged_url"]
      puts @merged_pdfs
      if @pdfs.empty?
      elsif @pdfs.count == @bank.documents.count
      else
        puts 'creating PDF'
        @pdfs.each do |pdf|
          req_test = Request.create(status: 'pending')
          Document.create!(bank: @bank, request: req_test, data_added: Time.now, file_url: pdf)
        end
        req_test = Request.create(status: 'pending')
        Document.create!(bank: @bank, request: req_test, data_added: Time.now, file_url: @merged_pdfs, file_ext: 'Merged Pdf')
      end
    end
  end

  private

  def retrieve_stats(ident)
    url = "https://bank-price-api.herokuapp.com/retrievestats?ident=#{ident}"
    JSON.parse(open(url).read)
  end

  @@demand_deposits = {
    demand_deposit: {
      commissions:
        {
        statement: [
          "Emissão de extrato",
          "Extrato Integrado",
          "Extrato Mensal",
          "Extrato integrado",
          "Extrato avulso"
        ],
        documents_copy: [
          "Fotocópias de segundas vias de talões de depósito",
          "Emissão 2ªs Vias de Avisos e Outros Documentos",
          "Extracto avulso",
          "Segundas vias (pedido na agência)"
        ],
        acc_manteinance: [
          "Manutenção de conta",
          "Comissão de manutenção de conta",
          "Comissão de Manutenção de Conta",
          "Manutenção de Conta Pacote",
          "Manutenção de Conta Base",
          "Manutenção de Conta Serviços Mínimos Bancários"
        ],
        withdraw: [
          "Levantamento de numerário",
          "Levantamento de numerário ao balcão",
          "Comissão de Levantamento",
          "Levantamento de Numerário ao Balcão",
          "Levantamento de Numerário ao Balcão"
        ],
        online_service: [
          "Adesão ao serviço de banca à distância",
          "Adesão ao serviço online"
        ],
        cash_deposit: [
          "Depósito de moedas metálicas",
          "Depósito de moedas",
          " Depósito em moeda metálica (>= 100 moedas)",
          "Depósito de moedas ao balcão",
          "Depósito de dinheiro ao balcão",
          "Depósito em moeda metálica (>= 100 moedas)"
        ],
        change_holder: [
          "Alteração de titulares",
          "Alteração de titularidade",
          "Comissão de Alteração de Titularidade",
          "Alteração de titularidade / intervenientes",
          "Alteração de titularidade (titular/ representante)"
        ],
        bank_overdraft: [
          "Comissões por descoberto bancário",
          "Descoberto bancário",
          "Comissões por Descoberto Bancário"
        ],
        movement_consultation: [
          "Consulta de Movimentos de conta DO com",
          "Consulta de movimentos ao balcão"
        ],
        balance_inquiry: [
          "Pedido de saldo ao balcão",
          "Consulta de Saldo de conta DO com comprovativo"
        ]
      },
        portuguese: "Contas de Depósito"
    }
  }

  @@house_credit_com = {'administrative_serv':['Comissões associadas a atos administrativos 4.1 Não realização da escritura',
    'Alteração do local da escritura',
    'Declarações de dívida',
    'Mudança de regime de crédito',
    'Declarações de dívida',
    'Pedido de 2ª via de Caderneta Predial',
    'Emissão de declarações não obrigatórias por lei',
    'Emissão de 2ª vias de Declaração para efeitos de IRS – Urgente',
    'Emissão de 2º vias de Declaração para efeitos de IRS',
    'Emissão de 2ª vias de faturas',
    'Declaração de Dívida para Fins Diversos',
    'Declaração de Encargos com Prestações'],
'certificates':['Emolumentos do registo predial', 'registo predial',
'Certidão permanente on-line'],
'debt_recovery':['Comissão de recuperação de valores em dívida', 'Prestação até 50.000 €',
'Prestação > 50.000 €', 'Comissão de recuperação de valores em dívida',
'Prestação > 50.000,00€', 'Prestação ≤ 50.000,00€'],
'displacement':['Comissão de deslocação', 'Até 100 Kms', '101 a 250 Kms', '> 250 Kms '],
'early_payment':['Comissão de reembolso antecipado parcial', 'Taxa fixa', 'Taxa variável',
'Taxa fixa', 'Comissão de reembolso antecipado total', 'Comissão de antecipação',
'(pré.aviso 7 dias)', 'Comissão de compra antecipada', '(pré-aviso 10 dias)',
'Comissão de Reembolso Antecipado Parcial',
'Comissão de reembolso antecipado total'],
'evaluation':['Avaliação', 'Imóvel residencial',
'Garagens e arrecadações não anexas ao imóvel residencial', 'Avaliação do Imóvel'],
'formalization':['Comissão de formalização', 'Formalização'],
'process':['Processo', 'Abertura de Processo',
'Desistência ou não conclusão do processo por motivos imputáveis ao cliente'],
'inspections':['Vistorias', 'em caso de construção ou realização de obras'],
'reanalysis':['Reanálise'],
'settlement':['Comissão de Liquidação de Prestação', 'Liquidação de Prestação'],
'solicitors_notary':['Emolumentos notariais', 'Solicitadoria', 'Notiário'],
'statements':['Emissão de extratos de conta de empréstimos liquidados', 'extrato', 'extratos',
'extrato de conta', 'extrato mensal'],
'taxes':['Imposto do Selo sobre concessão de crédito', 'imposto', 'imposto de selo', 'impostos'],
'termination':['Cessação da posição contratual', 'cessação', 'rescisão', 'encerramento']}
end
