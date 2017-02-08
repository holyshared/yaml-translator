$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

dir = File.dirname(__FILE__)
translator = ::YamlTranslator.create(
  :google_translate,
  api_key: ENV['GOOGLE_TRANSLATE_API_KEY']
)

english_locale = translator.file("#{dir}/en.yml")
japanese_locale = english_locale.to(:ja)

p japanese_locale.to_s
p japanese_locale.save_to(dir)

german_locale = english_locale.to(:de)

p german_locale.to_s
p german_locale.save_to(dir)
