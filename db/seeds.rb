# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

articles = Article.create([
  { title: 'Effective Project Management Strategies', content: 'In today\'s dynamic business environment, effective project management is crucial for success. This article explores proven strategies and best practices for achieving project goals.' },
  { title: 'Navigating Leadership Challenges in a Globalized World', content: 'Leadership in a globalized context comes with unique challenges. This article discusses key challenges faced by leaders and offers insights into navigating complexities and fostering team success.'},
  { title: 'Strategies for Enhancing Workplace Productivity', content: 'Productivity is a key driver of organizational success. Learn practical strategies and techniques to enhance workplace productivity and create a positive work environment.'},
])

puts 'Seeds loaded successfully!'