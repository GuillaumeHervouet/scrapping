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
    name = row.css('td.cmc-table__cell--sort-by__name strong').text
    price = row.css('td.cmc-table__cell--sort-by__price').text.gsub("$", "").gsub(",", "").to_f

    cryptocurrencies << { name => price }
  end

  cryptocurrencies
end

cryptocurrencies_array = fetch_cryptocurrencies
puts cryptocurrencies_array
