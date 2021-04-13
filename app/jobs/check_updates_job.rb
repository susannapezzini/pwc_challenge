class CheckUpdatesJob < ApplicationJob
  queue_as :default

  def perform(bank_id)
    bank = Bank.find(bank_id)
    payload1 = {
      "#{bank.id}": {
        "url": bank.websites.first.url,
        #bp_bank_id: bank.bp_bank_id,
        "bp_bank_id": '', #test value
        "last_updated": bank.updated_at
      }  
    }

    result = HTTParty.post('https://bank-price-api.herokuapp.com/merge_pdfs', 
      :body => payload1.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    # result = {
    #   'status' => 'ok'
    # }

    if result['status'] == 'ok'
      url = 'https://bank-price-api.herokuapp.com/retrievepdfs'
      data = JSON.parse(open(url).read)

      sleep 119
      pdfs = data[bank.id.to_s]["list_pdfs"]["urls"]
      error = data[bank.id.to_s]["price_page"]["error"]
      if pdfs.empty?
        redirect_to bank_path(bank), notice: "#{error}"
      elsif pdfs.count == bank.documents.count
        redirect_to bank_path(bank), info: "No updates!"
      else
        pdfs.each do |pdf|
          req_test = Request.create(status: 'pending')
          Document.create(bank: bank, request: req_test, data_added: Time.now, file_url: pdf)
        end
        redirect_to bank_path(bank), info: "checking for updates ....#{pdfs}"
      end
    else
      redirect_to bank_path(bank), notice: "Ups! Something went wrong!"
    end
  end
end
