#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = WikiData::Category.new( 'Catégorie:Député de la XIVe législature de la Ve République', 'fr').member_titles |
        WikiData::Category.new( 'Catégorie:Député de la XIIIe législature de la Ve République', 'fr').member_titles |
        WikiData::Category.new( 'Catégorie:Député de la XIIe législature de la Ve République', 'fr').member_titles
puts "Fetching #{names.count}"

EveryPolitician::Wikidata.scrape_wikidata(names: { fr: names })
