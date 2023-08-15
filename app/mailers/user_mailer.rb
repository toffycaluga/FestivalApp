class UserMailer < ApplicationMailer
    def confirmation_email(user, festival)
      @user = user
      @festival = festival
      mail(to: @user.email, subject: 'Confirmación de Postulación')
    end
  end
  