# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'uri'
require 'net/http'

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMWI3NjZhODc5OTBkNGU2OWE3ZTJmODYyNTgzMzMyZSIsInN1YiI6IjY0ZDRjMjQ0ZjE0ZGFkMDBlM2I3MThmMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lgLifwBSCED2DDvXk2Ap3Ee6YjSdUJjFfjW-uP1KLBA'

response = http.request(request)

movies = JSON.parse(response.read_body)['results']

puts "Cleaning the DB..."

Movie.destroy_all

img_path = 'https://image.tmdb.org/t/p/original'

puts "Creating movies..."

movies.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: img_path + movie['poster_path'],
    rating: movie['vote_average']
  )
end

puts "... created #{Movie.count} movies"
