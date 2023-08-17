
class OrganizerMailer < ApplicationMailer
    def new_application_notification(organizer, apply)
      @organizer = organizer
      @apply = apply
      mail(to: @organizer.email, subject: 'Nueva postulación recibida')
    end
  end
  