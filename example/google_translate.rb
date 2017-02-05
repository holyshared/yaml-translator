$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

dir = File.dirname(__FILE__)
adapter = ::YamlTranslator::Adapters::GoogleTranslateAdapter.new(ENV['GOOGLE_TRANSLATE_API_KEY'])
translator = ::YamlTranslator::Translator.new(adapter)

english_locale = ::YamlTranslator::Locale.load_file("#{dir}/en.yml")
japanese_locale = english_locale.translate(translator, to: :ja)

p japanese_locale.to_s
p japanese_locale.save_to(dir)

german_locale = english_locale.translate(translator, to: :de)

p german_locale.to_s
p german_locale.save_to(dir)
