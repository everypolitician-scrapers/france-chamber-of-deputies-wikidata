#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/france-national-assembly-wikipedia', column: 'wikiname')
names.each_slice(50) do |sliced|
  EveryPolitician::Wikidata.scrape_wikidata(names: { fr: sliced })
end
