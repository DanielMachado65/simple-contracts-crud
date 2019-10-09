class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :require_auth_token, only: [:create], raise: false

  def login
    if @ambassador
      allow_token_to_be_used_only_for(@ambassador)
      api_success(@ambassador)
    else
      api_unauthorized('Credenciais erradas, por favor tente novamente')
    end
  end

  def destroy
    logout
  end

  # ----------------------------- User

  private

  def not_found_ambassador(params)
    api_unauthorized(registered: false,
                     msg: "A conta com #{params[:user][:fb_id].presence || params[:user][:email].presence} não existe")
  end

  def verify_params(params)
    @errors = []
    return (@errors << 'A requisição não tem o objeto embaixador') if params[:user].nil?

    verify_email_and_password(params)
    @errors
  end

  def verify_email_and_password(params)
    @error << 'Na requisição falta o email' if params[:user][:email].blank?
    @error << 'Na requisição falta o senha' if params[:user][:password].blank?
  end

  def allow_token_to_be_used_only_for(user)
    user.regenerate_token
  end

  def logout
    user = current_user
    return api_error('Não foi cadastrado') if user.nil?

    api_success('Foi deslogado com sucesso') if user.invalidate_token
  end
end
