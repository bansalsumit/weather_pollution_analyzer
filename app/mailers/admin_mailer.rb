class AdminMailer < ApplicationMailer
  def error_notification(subject, errors)
    @errors = errors
    mail(to: 'sbansal.mait@gmail.com', subject: subject) do |format|
      format.text { render plain: @errors }
    end
  end
end
