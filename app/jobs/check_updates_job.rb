require 'open-uri'
require 'net/http'
require 'json'
class CheckUpdatesJob < ApplicationJob
  queue_as :default

  def perform(bank_id)
    @bank = Bank.find(bank_id)
    @payload1 = {
      "#{@bank.id}": {
        "url": @bank.websites.first.url,
        "bp_bank_id": '', #test value
        "last_updated": @bank.updated_at
      }  
    }
    @result = HTTParty.post('https://bank-price-api.herokuapp.com/merge_pdfs', 
      :body => @payload1.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    if @result['status'] == 'ok'
      @data = merged_pdfs(@result['ident'])
      count = 0
      while @data['status'] == 'error' 
        sleep 2
        @data = merged_pdfs(@result['ident'])
        count += 1
        break if count == 100
        puts "Try #{count} times"
      end
      @pdfs =  @data.values[0]["list_pdfs"]["urls"]
      @merged_pdfs = @data.values[0]["list_pdfs"]["cloud_merged_url"]
      puts @merged_pdfs
      if @pdfs.empty?
      elsif @pdfs.count == (@bank.documents.count -1)
      else
        puts 'creating PDF'
        @pdfs.each do |pdf|
          req_test = Request.create(status: 'active')
          Document.create!(bank: @bank, request: req_test, data_added: Time.now, file_url: pdf)
        end
        req_test = Request.create(status: 'pending')
        Document.create!(bank: @bank, request: req_test, data_added: Time.now, file_url: @merged_pdfs, file_ext: 'Merged Pdf')
      end
    end
  end

  private

  def merged_pdfs(ident)
    url = "https://bank-price-api.herokuapp.com/retrievepdfs?ident=#{ident}"
    JSON.parse(open(url).read)
  end
end
