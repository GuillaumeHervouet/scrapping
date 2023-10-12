require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  email = page.xpath('//section[2]//tr[4]/td[2]').text
  email
end
def get_townhall_urls(annuaire_url)
    page = Nokogiri::HTML(URI.open(annuaire_url))
    townhall_links = page.xpath('//a[@class="lientxt"]/@href').map do |link|
      "https://www.annuaire-des-mairies.com/val-d-oise.html" + link.text[1..-1]  # [1..-1] pour supprimer le premier caractère qui est un point.
    end
    townhall_links
  end
  def get_all_emails(annuaire_url)
    urls = get_townhall_urls(annuaire_url)
    results = []
    
    urls.each do |url|
      town_name = url.split('/')[-1].gsub('.html', '').capitalize
      email = get_townhall_email(url)
      results << { town_name => email }
    end
  
    results
  end
    