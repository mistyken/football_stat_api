# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
player = Player.create(:name => 'Ahmad Bradshaw', :pid => '8f22eb36-5282-407a-b6f9-f9b62e5f7318', :position => 'RB')
player.Receiving.create(:eid => '8f22eb36-5282-407a-b6f9-f9b62e5f73182014REG4re', :yds => '20', :tds => '1', :rec => '2')
player.Rushing.create(:eid => '8f22eb36-5282-407a-b6f9-f9b62e5f73182014REG4ru', :yds => '32', :att => '9', :tds => '0', :fum => '0')

player = Player.create(:name => 'Daniel Herron', :pid => '99c4968c-f811-4343-8cba-4bdd2884d734', :position => 'RB')
player.Rushing.create(:eid => '99c4968c-f811-4343-8cba-4bdd2884d7342014REG4ru', :yds => '24', :att => '7', :tds => '0', :fum => '0')

player = Player.create(:name => 'Andrew Luck', :pid => 'e3181493-6a2a-4e95-aa6f-3fc1ddeb7512', :position => 'QB')
player.Rushing.create(:eid => 'e3181493-6a2a-4e95-aa6f-3fc1ddeb75122014REG4ru', :yds => '-1', :att => '1', :tds => '0', :fum => '0')
player.Passing.create(:eid => 'e3181493-6a2a-4e95-aa6f-3fc1ddeb75122014REG4pa', :yds => '393', :att => '41', :tds => '4', :cmp => '29', :int => '1')