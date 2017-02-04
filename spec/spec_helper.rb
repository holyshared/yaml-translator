$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'yaml-translator'
require 'helpers/locale_helper'

RSpec.configure do |c|
  c.include Helpers::LocaleHelper
end
