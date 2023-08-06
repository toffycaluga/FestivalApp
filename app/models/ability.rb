# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    case user.role
    when 'Admin'
      can :manage, :all
    when 'Jurado'
      # Definir las habilidades del jurado aquí, por ejemplo:
      # can :read, Submission
    when 'Usuario'
      can :read , Festival
      # Definir las habilidades del usuario aquí
    when 'Organizador'
      # Definir las habilidades del organizador aquí
    else
      # Por defecto, los usuarios no autenticados pueden ver la página de inicio de sesión.
      can :read, :all
    end
  end
end
