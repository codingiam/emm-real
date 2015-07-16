require 'emm_real/version'

require 'sequel'
require 'rss'
require 'open-uri'
require 'yaml'

DB = Sequel.connect(YAML::load_file('config/database.yml'))

require 'emm_real/advert'

module EmmReal
  URL = 'http://www.emaramures.ro/Imobiliare-Maramures/RSS.aspx'

  class << self
    def fetch
      open(URL) do |rss|
        RSS::Parser.parse(rss)
      end.items.map { |item| { title: item.title, description: item.description, link: item.link, published_at: item.pubDate } }
    end

    def import(items)
      items
    end

    def notify(imported_items)
      imported_items
    end

    def call
      EmmReal.notify(EmmReal.import(EmmReal.fetch))
    end
  end
end
