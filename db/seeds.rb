# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Crear un usuario administrador
admin_user = User.create!(
    name: "Abraham Lillo",
    phone_number: "123456789",
    email: "p.abraham.lillo@gmail.com",
    password: "password", 
    role: "Admin",
    superadmin:true
  )

  
  puts "Usuario administrador creado correctamente."

# Crear las categorías
Category.create(name: 'Artista')
Category.create(name: 'Duo')
Category.create(name: 'Grupo/Troup')
Category.create(name: 'Payaso')

puts 'Categorías creadas exitosamente.'
