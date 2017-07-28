#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = {}
names['15'] = WikiData::Category.new( 'Catégorie:Député de la XVe législature de la Ve République', 'fr').member_titles
names['14'] = WikiData::Category.new( 'Catégorie:Député de la XIVe législature de la Ve République', 'fr').member_titles
names['13'] = WikiData::Category.new( 'Catégorie:Député de la XIIIe législature de la Ve République', 'fr').member_titles
names['12'] = WikiData::Category.new( 'Catégorie:Député de la XIIe législature de la Ve République', 'fr').member_titles

wanted = names.values.inject(:|)

# Find all Memberships since the start of the 12th Legislature
# This will ignore anyone who has a continuous membership from before
# that, but at the minute it's just a fallback for people missing from
# the Categories above, so should be Good Enough For Now
sparq = <<EOS
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 ?position_statement .
    ?position_statement ps:P39 wd:Q3044918 ;
                        pq:P580 ?start_date .
    FILTER (?start_date >= "2002-06-19T00:00:00Z"^^xsd:dateTime) .
  }
EOS
p39s = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { fr: wanted }, batch_size: 250)
