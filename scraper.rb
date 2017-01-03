#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = {}
names['14'] = WikiData::Category.new( 'Catégorie:Député de la XIVe législature de la Ve République', 'fr').member_titles
names['13'] = WikiData::Category.new( 'Catégorie:Député de la XIIIe législature de la Ve République', 'fr').member_titles
names['12'] = WikiData::Category.new( 'Catégorie:Député de la XIIe législature de la Ve République', 'fr').member_titles

wanted = names.values.inject(:|)
puts "Fetching #{wanted.count}"

EveryPolitician::Wikidata.scrape_wikidata(names: { fr: wanted }, batch_size: 250)
