$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

translator = ::YamlTranslator.create(
  :google_translate,
  api_key: ENV['GOOGLE_TRANSLATE_API_KEY']
)

diff_some_dir = File.join(File.dirname(__FILE__), 'diff/some')
diff_locale = translator.file("#{diff_some_dir}/en.yml").diff("#{diff_some_dir}/new.en.yml")
diff_locale.to(:ja).save_to("/tmp", prefix: 'some_diff.')

# diff nothing!!
diff_none_dir = File.join(File.dirname(__FILE__), 'diff/none')
diff_locale = translator.file("#{diff_none_dir}/en.yml").diff("#{diff_none_dir}/new.en.yml")
diff_locale.to(:ja).save_to("/tmp", prefix: 'no_diff.')
