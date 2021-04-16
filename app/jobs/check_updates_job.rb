require 'open-uri'
require 'net/http'
require 'json'
class CheckUpdatesJob < ApplicationJob
  queue_as :default

  def perform(bank_id)
    @bank = Bank.find(bank_id)
    @payload1 = {
      "#{@bank.id}": {
        url: @bank.websites.first.url,
        bp_bank_id: @bank.bp_bank_id, #test value
        last_updated: @bank.updated_at
      }  
    }
    puts 'hi'
    @result = HTTParty.post('https://bank-price-api.herokuapp.com/merge_pdfs', 
      :body => @payload1.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    if @result['status'] == 'ok'
      sleep 60  
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
      @bp_pdf = @data.values[0]["bp_pdf_url"]
      @merged_pdfs = @data.values[0]["list_pdfs"]["cloud_merged_url"]
      puts @merged_pdfs
      puts @bp_pdf
      # if @pdfs.empty?
      # elsif @pdfs.count == (@bank.documents.count - 1)
      #   req_test = Request.create(status: 'active', content: 'Latest merged pdf')
      #   req_test_bp = Request.create(status: 'pending', content: 'Banco Do Portugal Source')
      #   Document.create!(bank: @bank, request: req_test, data_added: Time.now, file_url: @merged_pdfs, file_ext: 'Merged Pdf')
      #   Document.create!(bank: @bank, request: req_test_bp, data_added: Time.now, file_url: @bp_pdf, file_ext: 'Banco Portugal')
      # else
        puts 'creating PDF'
        req_test_bp = Request.create(status: 'pending', content: 'Banco Do Portugal Source')
        req_test = Request.create(status: 'active', content: 'Latest merged pdf.')
        Document.create!(bank: @bank, request: req_test, data_added: Time.now, file_url: @merged_pdfs, file_ext: 'Merged Pdf')
        Document.create!(bank: @bank, request: req_test_bp, data_added: Time.now, file_url: @bp_pdf, file_ext: 'Banco Portugal')
        req_test2 = Request.create(status: 'active', content: 'Pdfs retrieved')
        @pdfs.each do |pdf|
          Document.create!(bank: @bank, request: req_test2, data_added: Time.now, file_url: pdf)
        end
      # end
    end
  end

  private

  def merged_pdfs(ident)
    url = "https://bank-price-api.herokuapp.com/retrievepdfs?ident=#{ident}"
    JSON.parse(open(url).read)
  end
end
