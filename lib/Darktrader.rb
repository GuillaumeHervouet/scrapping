require 'nokogiri'
require 'open-uri'

def fetch_cryptocurrencies
  url = 'https://coinmarketcap.com/all/views/all/'

  # Récupération du contenu de la page
  html_content = URI.open(url).read
  doc = Nokogiri::HTML(html_content)

  # Array pour stocker les résultats
  cryptocurrencies = []

  # Scrapping des noms et des prix des cryptos

  doc.css('tr.cmc-table-row').each do |row|
    name = row.css('td:nth-child(3) a').text
    price = row.css('td:nth-child(5) a').text.gsub("$", "").gsub(",", "").to_f
  
    cryptocurrencies << { name => price }
  end
  
  cryptocurrencies
end




cryptocurrencies_array = fetch_cryptocurrencies
puts cryptocurrencies_array
