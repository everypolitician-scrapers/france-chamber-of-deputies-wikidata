#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'

WikiData::Category.new('Catégorie:Député de la XIVe législature de la Ve République', 'fr').wikidata_ids.each do |id|
  data = WikiData::Fetcher.new(id: id).data('fr','en') or next
  puts '%s %s' % [data[:id], data[:name]]
  ScraperWiki.save_sqlite([:id], data)
end
