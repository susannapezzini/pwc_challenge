class RequestsController < ApplicationController
    before_action :set_request, only: %i[update]
  
  def new
    @request = Request.new
    @document = Document.find(params[:document_id])
    @products = Product.all
    @bp_bank_id = @document.bank.bp_bank_id
    @document.request = @request
    @bank_portugal_pdf = "https://clientebancario.bportugal.pt/sites/default/files/precario/#{@bp_bank_id}_/#{@bp_bank_id}_PRE.pdf"
  end

  def create

    @document = Document.find(params[:document_id])
    @bp_bank_id = @document.bank.bp_bank_id
    @bank = @document.bank
    # @bank_portugal_pdf = "https://clientebancario.bportugal.pt/sites/default/files/precario/#{@bp_bank_id}_/#{@bp_bank_id}_PRE.pdf"
    @bank_portugal_pdf = @document.file_url
    @request = Request.new(request_params)
    pages = request_params['pages'].split(',').map(&:strip)
    @request.pages = pages
    @merged_pdf = @bank.documents.where(file_ext: 'Merged Pdf').last

    @request.bp_bank_pdf = @bank_portugal_pdf
    @request.bp_bank_id = @bp_bank_id
    @request.status = "pending"
    @request.save
    @document.request = @request
    @document.save
    if @request.save
      ProductUpdateJob.perform_later(@document.bank_id, @bp_bank_id, @bank_portugal_pdf, @request.product, @merged_pdf.file_url, @request.id)
      redirect_to dashboard_path, notice: "This will take a while, hang in there!"
    else
      render :new
    end

  end
  
  
  def update
    @request.status = 'active'
    @request.save
    redirect_to dashboard_path(anchor: "request_#{@request.id}"), notice: 'Request successfully updated'
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:content, :status, :product, :document, :pages)
  end
end
