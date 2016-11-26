# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'nokogiri'
require 'addressable/uri'
require 'json'
Coord.delete_all
page = Nokogiri::HTML(open('http://www.realestate.ru/streets/'))
i = 0
while i<50 do
  begin
    street = page.css('a.street-link')[rand(1676)].text
    street = street.gsub(/ ул\Z/, ' улица').gsub(/ пр-кт\Z/,' проспект').gsub(/ наб\Z/,' набережная')\
          .gsub(/ пер\Z/,' переулок').gsub(/ б-р\Z/,' бульвар').gsub(/ ш\Z/,' шоссе')
    house = rand(10)
    uri = Addressable::URI.parse("https://geocode-maps.yandex.ru/1.x/?geocode=Москва,+#{street},+дом+#{house}&format=json")
    uri.normalize!
    response = JSON.parse(open(uri).read)
    pos = response['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['Point']['pos']
    longitude, latitude = pos.split.map(&:to_f)
    coord = Coord.new(city: 'Москва', street: street, house: house, longitude: longitude, latitude: latitude)
    i+=1 if coord.save
  rescue
    next
  end
end
