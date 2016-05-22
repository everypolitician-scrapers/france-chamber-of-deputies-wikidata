#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

# names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/france-national-assembly-wikipedia', column: 'wikiname')
# names.shuffle.each_slice(50) do |sliced|
  # EveryPolitician::Wikidata.scrape_wikidata(names: { fr: sliced })
# end
#

# names = EveryPolitician::Wikidata.wikipedia_xpath( 
  # url: 'https://fr.wikipedia.org/wiki/Liste_des_députés_de_la_XIVe_législature_de_la_Cinquième_République',
  # after: '//span[@id="Liste_des_d.C3.A9put.C3.A9s"]',
  # before: '//span[@id="Notes_et_r.C3.A9f.C3.A9rences"]',
  # xpath: '//table//tr//td[1]//a[not(@class="new")]/@title',
# ) 

names = WikiData::Category.new( 'Catégorie:Député de la XIVe législature de la Ve République', 'fr').member_titles

EveryPolitician::Wikidata.scrape_wikidata(names: { fr: names }, batch_size: 100)
