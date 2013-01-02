class VerificationsController < ApplicationController
  
  def verify
    from = params[:sender]
    code = rand(1000).to_s
    if VerificationMailer.verify_email_address(from, code).deliver
      encrypted_code = Digest::MD5.hexdigest(code)
      render json: {status: 'success', code: encrypted_code}
    else
      render json: {status: 'failed', code: nil}
    end
  end
end