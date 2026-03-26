# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

properties = [
  { title: "Modern Downtown Apartment", address: "123 Main St, City Center", price: 350000, description: "A beautiful 2-bedroom apartment with stunning city views. Modern kitchen, hardwood floors, and in-unit laundry.", image_url: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop" },
  { title: "Cozy Suburban Home", address: "456 Oak Lane, Suburbs", price: 525000, description: "Spacious 3-bedroom home with a large backyard. Perfect for families with updated bathrooms and a two-car garage.", image_url: "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&h=600&fit=crop" },
  { title: "Luxury Beachfront Villa", address: "789 Ocean Drive, Coastal Bay", price: 1200000, description: "Stunning beachfront property with private beach access. 4 bedrooms, pool, and panoramic ocean views.", image_url: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800&h=600&fit=crop" },
  { title: "Historic Townhouse", address: "321 Heritage Ave, Old Town", price: 475000, description: "Charming 2-story townhouse with original architectural details. Walking distance to shops and restaurants.", image_url: "https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?w=800&h=600&fit=crop" },
  { title: "Mountain Retreat Cabin", address: "555 Pine Road, Mountain View", price: 280000, description: "Peaceful 3-bedroom cabin surrounded by nature. Great for weekend getaways with a fireplace and deck.", image_url: "https://images.unsplash.com/photo-1518780664697-55e3ad937233?w=800&h=600&fit=crop" }
]

properties.each do |prop|
  property = Property.find_or_initialize_by(title: prop[:title])
  property.assign_attributes(
    address: prop[:address],
    price: prop[:price],
    description: prop[:description],
    image_url: prop[:image_url]
  )
  property.save!
end

puts "Created #{Property.count} properties"
