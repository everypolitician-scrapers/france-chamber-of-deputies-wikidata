#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = {}
names['15'] = WikiData::Category.new( 'Catégorie:Député de la XVe législature de la Ve République', 'fr').member_titles
names['14'] = WikiData::Category.new( 'Catégorie:Député de la XIVe législature de la Ve République', 'fr').member_titles
names['13'] = WikiData::Category.new( 'Catégorie:Député de la XIIIe législature de la Ve République', 'fr').member_titles
names['12'] = WikiData::Category.new( 'Catégorie:Député de la XIIe législature de la Ve République', 'fr').member_titles

wanted = names.values.inject(:|)

# Find all Memberships since the 12th Legislature
sparq = <<EOS
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 ?ps .
    ?ps ps:P39 wd:Q3044918 ; pq:P580 ?start_date .
    OPTIONAL { ?ps pq:P582 ?end_date }
    FILTER(!BOUND(?end_date) || (?end_date >= "2002-06-19T00:00:00Z"^^xsd:dateTime))
  }
EOS
p39s = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { fr: wanted }, batch_size: 250)
