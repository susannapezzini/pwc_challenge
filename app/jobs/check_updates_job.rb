require 'open-uri'
class CheckUpdatesJob < ApplicationJob
  queue_as :default

  def perform(bank_id)
    # Check updates
    @bank = Bank.find(bank_id)
    @payload1 = {
      "#{@bank.id}": {
        "url": @bank.websites.first.url,
        #bp_bank_id: bank.bp_bank_id,
        "bp_bank_id": '', #test value
        "last_updated": @bank.updated_at
      }  
    }
    
    @result = HTTParty.post('https://bank-price-api.herokuapp.com/merge_pdfs', 
      :body => @payload1.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
      # result = {
        #   'status' => 'ok'
        # }
        puts @result.body
        if @result['status'] == 'ok'
          # Merge Pdfs
          puts @result['ident']
          @url = "https://bank-price-api.herokuapp.com/retrievepdfs?ident=#{@result['ident']}"
          @data = JSON.parse(open(@url).read)
          sleep 240
          puts 'point 2'
          puts @data
          @pdfs = @data.values["list_pdfs"]["urls"]
      puts 'point 3'
      Bank.create!(name: 'Test Bank')
      @pdfs.each do |pdf|
        req_test = Request.create(status: 'pending')
        Document.create(bank: @bank, request: req_test, data_added: Time.now, file_url: pdf)
      end
    end
  end
end
