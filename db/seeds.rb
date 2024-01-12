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
  { title: 'Effective Project Management Strategies', content: 'In todays dynamic business environment, effective project management is crucial for success. This article explores proven strategies and best practices for achieving project goals.'},
  { title: 'Navigating Leadership Challenges in a Globalized World', content: 'Leadership in a globalized context comes with unique challenges. This article discusses key challenges faced by leaders and offers insights into navigating complexities and fostering team success.'},
  { title: 'Strategies for Enhancing Workplace Productivity', content: 'Productivity is a key driver of organizational success. Learn practical strategies and techniques to enhance workplace productivity and create a positive work environment.'},
  { title: 'How to Build a Successful Team', content: 'Building a successful team is a complex process. This article explores key factors that contribute to team success and offers practical tips for leaders to build high-performing teams.'},
  { title: 'How to Create a Positive Work Environment', content: 'A positive work environment is essential for employee well-being and organizational success. This article explores key factors that contribute to a positive work environment and offers practical tips for leaders to create a positive work environment.'},
  { title: 'How to Manage Conflict in the Workplace', content: 'Conflict is inevitable in the workplace. This article explores key factors that contribute to workplace conflict and offers practical tips for leaders to manage conflict effectively.'},
  { title: 'How to Manage Remote Teams', content: 'Managing remote teams is a complex process. This article explores key factors that contribute to remote team success and offers practical tips for leaders to manage remote teams effectively.'},
  { title: 'How to Manage Stress in the Workplace', content: 'Stress is a common experience in the workplace. This article explores key factors that contribute to workplace stress and offers practical tips for leaders to manage stress effectively.'},
])

puts 'Seeds loaded successfully!'