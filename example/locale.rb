$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'

dir = File.dirname(__FILE__)
english_locale1 = ::YamlTranslator.load_file("#{dir}/en.yml")
english_locale2 = ::YamlTranslator.load_file("#{dir}/new.en.yml")

diff_locale = english_locale1.diff(english_locale2)

merged_locale = english_locale1.merge(diff_locale)
merged_locale.save_to("/tmp")
