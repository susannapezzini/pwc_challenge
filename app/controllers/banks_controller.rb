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
    CheckUpdatesJob.perform_later(@bank.id)
    redirect_to bank_path(@bank), info: "Processing... This will "
  end

  def merged_pdfs
    fetch_bank

    url = 'https://bank-price-api.herokuapp.com/retrievepdfs'
    @data = JSON.parse(open(url).read)

    # if result['status'] == 'ok'data
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
    abanca_hash = {
      "1": {
        "products": {
          "demand_deposit": {
            "subproducts": {
              "Conta D.O.": {
                "Account Maintenance": "15,00"
              },
              "Conta Ordenado": {
                "Account Maintenance": "0,00"
              },
              "Conta Standard": {
                "Account Maintenance": "0,00"
              },
              "Conta Future": {
                "Account Maintenance": "0,00"
              },
              "Conta Kids": {
                "Account Maintenance": "0,00"
              },
              "Conta Base": {
                "Account Maintenance": "10,00"
              },
              "Conta Private": {
                "Account Maintenance": "8,00"
              },
              "Conta Value": {
                "Account Maintenance": "5,00"
              },
              "Conta Smart": {
                "Account Maintenance": "5,00"
              },
              "Conta Futuro": {
                "Account Maintenance": "0,00"
              },
              "Conta Moeda Estrangeira e": {
                "Account Maintenance": "15,00"
              },
              "Conta ABANCA Internacional.": {
                "Account Maintenance": "15,00"
              },
              "Conta para clientes dos 18 aos 28 anos.": {
                "Account Maintenance": "0,23"
              },
              "Conta para clientes dos 0 aos 17 anos.": {
                "Account Maintenance": "0,23"
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
  banco_bic_hash = {
    "3": {
      "products": {
        "demand_deposit": {
          "subproducts": {
            "Conta \u00e0 Ordem (5),": {},
            "Conta \u00e0 Ordem Emigrantes (5),": {},
            "Conta Ordenado XL (12),": {},
            "Conta \u00e0 Ordem Sucursal Financeira Exterior Madeira (5)(6),": {},
            "Conta Privil\u00e9gio 55 (5)(7),": {},
            "Conta \u00e0 Ordem com Futuro 0,00 nan Nota 4": {
              "acc_manteinance": "0,00"
            },
            "Conta Cool (contrata\u00e7\u00f5es a partir de 13 de novembro 2014) 0,00 nan Notas 4,": {
              "acc_manteinance": "0,00"
            },
            "Conta \u00e0 Ordem Massa Insolvente 0,00 nan Nota 14": {
              "acc_manteinance": "0,00"
            },
            "Conta BIC Sal\u00e1rio Internacional (Fora de comercializa\u00e7\u00e3o) 5,00 / m\u00eas 60,00 IS 4,00% Notas": {},
            "Conta Base 5,00 / m\u00eas 60,00 IS 4,00% Notas 5, 8 3.": {},
            "Conta EuroBic Prime com domicilia\u00e7\u00e3o de vencimento Nota 15 Sem condi\u00e7\u00f5es de bonifica\u00e7\u00e3o 5,50": {},
            "Conta EuroBic Prime sem domicilia\u00e7\u00e3o de vencimento Nota 15 Sem condi\u00e7\u00f5es de bonifica\u00e7\u00e3o 7,50": {},
            "Conta EuroBic 365 com domicilia\u00e7\u00e3o de vencimento Nota 16 Sem condi\u00e7\u00f5es de bonifica\u00e7\u00e3o 4,25": {},
            "Conta EuroBic 365 sem domicilia\u00e7\u00e3o de vencimento Nota 16 Sem condi\u00e7\u00f5es de bonifica\u00e7\u00e3o 6,00": {},
            "Conta EuroBic S\u00e9nior Sem cr\u00e9dito de vencimento e recursos \u2264 35.000 \u20ac 4,00 /": {},
            "Conta EuroBic Mais (Fora de comercializa\u00e7\u00e3o) Sem cr\u00e9dito de vencimento 7,00 / m\u00eas 84,00": {},
            "Conta \u00e0 Ordem.": {},
            "Conta BIC Sal\u00e1rio Internacional.": {},
            "Conta de Servi\u00e7os M\u00ednimos Banc\u00e1rios.": {},
            "Conta Base t\u00eam acesso gratu\u00edto a 3 levantamentos de numer\u00e1rio por m\u00eas.": {},
            "Conta de Servi\u00e7os M\u00ednimos Banc\u00e1rios,": {},
            "Conta Base.": {},
            "General": {
              "acc_manteinance": "9,30",
              "withdraw": "5,00",
              "change_holder": "7,00",
              "balance_inquiry": "1,00"
            }
          },
          "n_subproducts": 22
        }
      }
    }
  }

  banco_ctt_hash = {
    "5": {
      "products": {
        "demand_deposit": {
          "subproducts": {
            "Conta J\u00fanior (Montante M\u00ednimo de Abertura 25,00\u20ac) Comiss\u00f5es durante a vig\u00eancia do contrato 1.Levantamento": {},
            "Conta Base (Montante M\u00ednimo de Abertura 100,00\u20ac) Comiss\u00f5es durante a vig\u00eancia do contrato 1.Levantamento": {},
            "General": {
              "statement": "0,00",
              "documents_copy": "0,00",
              "acc_manteinance": "5,00",
              "withdraw": "5,00",
              "cash_deposit": "5,00",
              "change_holder": "5,00",
              "bank_overdraft": "0,00",
              "movement_consultation": "0,00",
              "balance_inquiry": "0,00"
            }
          },
          "n_subproducts": 2
        }
      }
    }
  }

  banco_bai_hash = {
    "4": {
      "products": {
        "demand_deposit": {
          "subproducts": {
            "Conta de Servi\u00e7os M\u00ednimos Banc\u00e1rios Comiss\u00f5es vig\u00eancia contrato 1.": {},
            "General": {
              "withdraw": "20,00",
              "statement": "0,00"
            },
            "Conta de Servi\u00e7os M\u00ednimos Banc\u00e1rios Comiss\u00f5es vig\u00eancia contrato ": {
              "acc_manteinance": "5,00"
            }
          },
          "n_subproducts": 2
        }
      }
    }
  }

    # Price.destroy_all
    # Fee.destroy_all
    # Document.destroy_all
    # Subproduct.destroy_all
    # Request.destroy_all
    # Group.destroy_all

    # create_seeds_dd("Banco BAI", banco_bai_hash, 4)
    # create_seeds_dd("Banco CTT", banco_ctt_hash, 5)
    # create_seeds_dd("Banco BIC", banco_bic_hash, 3)
    # create_seeds_dd("ABANCA", abanca_hash, 1)

  end


  

  
  private

  def create_price_and_fee(fee_name, price, product, sub, doc)
    fee = Fee.find_by(name: fee_name)
    if fee.nil?
      fee = Fee.create!(product_id: product.id, name: fee_name)
    end

    p Price.create!(amount: price, fee_id: fee.id, subproduct_id: sub.id, document_id: doc.id)
  end

  def create_seeds_dd(bank_name, json_hash, bank_id_temp)
    current_bank = Bank.find_by(name: bank_name)
    current_request = Request.create(content: "Manual Request", status: "Pending")
    current_doc = Document.create(bank_id: current_bank.id, request_id: current_request.id)

    json_hash[:"#{bank_id_temp.to_s}"][:products][:demand_deposit][:subproducts].each do |subproduct, fee_price|
      current_product = Product.find_by(name: "Demand Deposits")
      if subproduct != :General
        current_sub = Subproduct.find_by(name: subproduct)

        if current_sub.nil? #not found
          current_sub = Subproduct.create!(bank_id: current_bank.id, product_id: current_product.id, name: subproduct)
        end

        fee_price.each do |fee, price|
          create_price_and_fee(fee, price, current_product, current_sub, current_doc)
        end
        
        json_hash[:"#{bank_id_temp.to_s}"][:products][:demand_deposit][:subproducts][:General].each do |fee, price|
          create_price_and_fee(fee, price, current_product, current_sub, current_doc)
        end
      end
    end
  end

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
