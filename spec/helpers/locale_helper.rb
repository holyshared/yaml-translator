require 'yaml'

module Helpers
  module LocaleHelper
    def load_yaml(name)
      path = "#{File.dirname(__FILE__)}/../fixtures/#{name.to_s}.yml"
      YAML.load(File::open(path, &:read))
    end
  end
end
