class UserMailer < ApplicationMailer
    def confirmation_email(user, festival)
      @user = user
      @festival = festival
      mail(to: @user.email, subject: 'Confirmación de Postulación')
    end

    def terms_notification_email(apply, user, festival)
      @user = user
      @festival = festival
      @apply = apply
      mail(to: @user.email, subject: "Acción requerida: Acepta los términos y condiciones para tu postulación")
    end
  end
  