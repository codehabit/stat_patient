# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_names = ["David", "John", "Sally", "Jane", "Martha", "Stuart", "Gregg", "Todd", "Suzanne", "Annika", "Bek", "Jonas", "Alex", "Rob", "Bill", "Ted", "Garth", "Wayne", "Mary", "Fred", "Josh", "Maggie", "Andrea", "Helen"]
last_names = ["Oliver", "Johnson", "Williamson", "Wilson", "Johnston", "Broome", "Leach", "Chisman", "Suarez", "Jiminez", "Frakenstein", "Jones", "Smith", "Miller", "Lively", "Beckstrom", "Youngberg", "Kallenberg", "Davidson", "Ebeka", "Ronson", "Blake", "Townsend", "Pitt"]
first_birthday = 30.years.ago

first_names.each_with_index do |first, i|
  Patient.create(first_name: first, last_name: last_names[i], date_of_birth: first_birthday + 1.month, email: "#{first.downcase}@statpatient.com")
end

