# controller for user
class Api::V1::ContractsController < Api::V1::ApiController

  skip_before_action :verify_authenticity_token
  before_action :set_contract, except: %I[create]
  # before_action :require_auth_token, except: %I[create]

  def show
    return api_not_found(data: 'não foi encontrado') if @contract.nil?

    api_success(data: {name: @contract.name,
                       initial_date: @contract.initial_date,
                       final_date: @contract.final_date,
                       url: url_for(@contract.pdf)})
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.pdf = params[:file] if params[:file].present?
    return api_success(data: url_for(@contract.pdf)) if @contract.save

    api_error(data: @contract.errors)
  end

  def update
    return api_not_found(data: 'não foi encontrado') if @contract.nil?

    if Contract.update(contract_params)
      @contract.pdf = params[:file] if params[:file].present?
      return api_success(data: url_for(@contract.pdf)) if @contract.save
    end

    api_error(data: @contract.errors)
  end

  def destroy
    return api_not_found(data: 'não foi encontrado') if @contract.nil?

    @contract.pdf.purge
    return api_success(data: 'foi deletado com sucesso') if @contract.destroy

    api_error(data: 'não foi possivel deletar')
  end


  private

  def contract_params
    params.permit(:name, :initial_date, :final_date, :user_id, :pdf)
  end

  def set_contract
    @contract = Contract.find_by(id: params[:id])
  end
end