$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'simplecov-console'

SimpleCov.add_filter do |source_file|
  filename = source_file.filename
  filename =~ /spec|fixtures|helpers/
end

SimpleCov.start

require 'yaml'
require 'yaml-translator'
require 'helpers/locale_helper'

if ENV['COVERALLS_REPO_TOKEN']
  require 'coveralls'
  Coveralls.wear!
else
  SimpleCov.formatters = [
    SimpleCov::Formatter::Console
  ]
end

RSpec.configure do |c|
  c.include Helpers::LocaleHelper
end
