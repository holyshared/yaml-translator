require 'yaml'

module Helpers
  module LocaleHelper
    def load_yaml(name)
      path = "#{File.dirname(__FILE__)}/../fixtures/#{name.to_s}.yml"
      YAML.load(File::open(path, &:read))
    end
    def load_locale(name)
      path = "#{File.dirname(__FILE__)}/../fixtures/#{name.to_s}.yml"
      YamlTranslator::Locale.load_file(path)
    end
  end
end
