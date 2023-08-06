# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Crear un usuario administrador
admin_user = User.create!(
    name: "Nombre del Admin",
    phone_number: "123456789",
    email: "admin@example.com",
    password: "password", # Cambia esta contraseña por una segura
    role: "Admin"
  )

  
  puts "Usuario administrador creado correctamente."

# Crear las categorías
Category.create(name: 'Artista')
Category.create(name: 'Duo')
Category.create(name: 'Grupo/Troup')
Category.create(name: 'Payaso')

puts 'Categorías creadas exitosamente.'
