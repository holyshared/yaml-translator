$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

dir = File.dirname(__FILE__)
adapter = ::YamlTranslator::Adapters::GoogleTranslateAdapter.new(ENV['GOOGLE_TRANSLATE_API_KEY'])
translator = ::YamlTranslator::Translator.new(adapter)
result = translator.translate_file("#{dir}/en.yml", to: :ja)

p result.to_s
p result.save_to(dir)
