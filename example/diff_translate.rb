$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

dir = File.dirname(__FILE__)
translator = ::YamlTranslator.create(
  :google_translate,
  api_key: ENV['GOOGLE_TRANSLATE_API_KEY']
)

diff_locale = translator.file("#{dir}/en.yml").diff("#{dir}/new.en.yml")
diff_locale.to(:ja).save_to("/tmp")
