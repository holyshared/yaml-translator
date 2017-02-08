$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

dir = File.dirname(__FILE__)
adapter = ::YamlTranslator::Adapters::GoogleTranslateAdapter.new(ENV['GOOGLE_TRANSLATE_API_KEY'])
translator = ::YamlTranslator::Translator.new(adapter)

diff_locale = translator.file("#{dir}/en.yml").diff("#{dir}/new.en.yml")
diff_locale.to(:ja).save_to("/tmp")
