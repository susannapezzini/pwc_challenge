require 'net/http'
require 'json'
require 'open-uri'

class BanksController < ApplicationController
  before_action :fetch_bank, only: %i[show edit update destroy check_updates]
  def index
    @banks = Bank.all

    if params[:query].present?
      sql_query = " \
        banks.name @@ :query \
        OR banks.country @@ :query \
      "
      @banks = @banks.where(sql_query, query: "%#{params[:query]}%")
    end
    if @banks.empty?
      flash.now[:alert] = "Sorry, we could not find what you're looking for."
    end
  end

  def show
    @users = @bank.users
    @subproducts = @bank.subproducts
  end

  def new
    @user = current_user
    @bank = Bank.new
    @website = Website.new
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to banks_path, notice: 'Bank was successfully created'
    else
      render :new
    end

    Website.create(url: params[:website][:url], bank_id: @bank.id)
  end

  def edit
    @websites = @bank.websites
  end

  def update
    if current_user.admin?
      @bank.update(bank_params)
      redirect_to bank_path(@bank)
    else
      flash.now[:alert] = "Sorry, you dont have that permission."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if current_user.admin?
      @bank.destroy
      redirect_to banks_path, notice: "The bank, its subproducts, and its users were deleted successfully."
    else
      flash.now[:alert] = "Sorry, you dont have that permission."
      # redirect_to dashboard_path
      redirect_back(fallback_location: root_path)
    end
  end

  def manage
    @websites = @bank.websites
    @new_website = Website.new
  end

  def check_updates
    payload1 = {
      "#{@bank.id}": {
        "url": @bank.websites.first.url,
        #bp_bank_id: @bank.bp_bank_id,
        "bp_bank_id": '', #test value
        "last_updated": @bank.updated_at
      }  
    }

    result = HTTParty.post('https://bank-price-api.herokuapp.com/merge_pdfs', 
      :body => payload1.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    # result = {
    #   'status' => 'ok'
    # }

    if result['status'] == 'ok'
      merged_pdfs

      sleep 119
      @pdfs = @data[@bank.id.to_s]["list_pdfs"]["urls"]
      @error = @data[@bank.id.to_s]["price_page"]["error"]
      if @pdfs.empty?
        redirect_to bank_path(@bank), notice: "#{@error}"
      elsif @pdfs.count == @bank.documents.count
        redirect_to bank_path(@bank), info: "No updates!"
      else
        @pdfs.each do |pdf|
          req_test = Request.create(status: 'pending')
          Document.create(bank: @bank, request: req_test, data_added: Time.now, file_url: pdf)
        end
        redirect_to bank_path(@bank), info: "checking for updates ....#{@pdfs}"
      end

    else
      redirect_to bank_path(@bank), notice: "Ups! Something went wrong!"
    end
  end

  def merged_pdfs
    fetch_bank

    url = 'https://bank-price-api.herokuapp.com/retrievepdfs'
    @data = JSON.parse(open(url).read)

    # if result['status'] == 'ok'
    # else
    # end

    
    # payload2 = { 
    #   "#{@bank.id}": {
    #     "url": @bank.websites.first.url,
    #     #bp_bank_id: @bank.bp_bank_id,
    #     "bp_bank_id": 44, #test value
    #     "num_pdfs": 2,
    #     "last_updated": @bank.updated_at,
    #     "cloud_merged_url": 'https://www.cloudinary.ao/mega_mega_file_merged_bp0038.pdf'
    #     'products': [
    #               {
    #                 'demand_deposit': comm_hash_1,
    #                 'pages': [3,4] (from merged pdf)
    #               },
    #               {
    #                 'housing_credit': comm_hash_2,
    #                 'pages': [9] (from merged pdf)
    #               }
    #           ]
    #   }
    # }

    # result = HTTParty.post('https://bank-price-api.herokuapp.com/get_stats', 
    #     :body => payload2.to_json,
    #     :headers => { 'Content-Type' => 'application/json' } )
  end

  # def users
  #   if current_user.admin?
  #     @bank.users 
  #   else
  #     flash.now[:alert] = "Sorry, you dont have that permission."
  #     # redirect_to dashboard_path
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  def parse
    # t[:"1"][:products][:demand_deposit].each do |category_name, fees|
    #   fees.each do |fee|
    #     #puts "Category #{category_name} #{fee}"
    #     Fee.create!(name: fee, category: category_name)
    #   end
    # end

    Price.destroy_all
    Fee.destroy_all
    Document.destroy_all
    Subproduct.destroy_all
    Request.destroy_all
    Group.destroy_all

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
    current_request = Request.create(content: "Manual Request", status: "Pending")
    current_doc = Document.create(bank_id: abanca.id, request_id: current_request.id)

    abanca_hash[:"1"][:products][:demand_deposit][:subproducts].each do |subproduct, fee_price|
      dd = Product.find_by(name: "Demand Deposits")
      unless current_sub = Subproduct.find_by(name: subproduct)
        p current_sub = Subproduct.create!(bank_id: abanca.id, product_id: dd.id, name: subproduct)
      end

      fee_price.each do |fee, price|
        unless current_fee = Fee.find_by(name: fee)
          current_fee = Fee.create!(product_id: dd.id, name: fee)
        end

        p Price.create!(amount: price, fee_id: current_fee.id, subproduct_id: current_sub.id, document_id: current_doc.id)
      end
    end


    raise

  end
  private

  def fetch_bank
    @bank = Bank.find(params[:id])
  end

  def bank_params
    params.require(:bank).permit(:name, :website, :address, :country, :website, :photo, files: [])
  end

  def web_params
    params.require(:bank).permit[:website]
  end
end
