#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'

WikiData::Category.new('Catégorie:Député de la XIVe législature de la Ve République', 'fr').wikidata_ids.each_with_index do |id, i|
  puts i if (i % 50).zero?
  data = WikiData::Fetcher.new(id: id).data('fr','en') or next
  ScraperWiki.save_sqlite([:id], data)
end
