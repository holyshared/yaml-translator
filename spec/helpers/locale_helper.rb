require 'yaml'

module Helpers
  module LocaleHelper
    def yaml_path(name)
      "#{File.dirname(__FILE__)}/../fixtures/#{name.to_s}.yml"
    end
    def yaml_contents(name)
      File::open(yaml_path(name), &:read)
    end
    def load_yaml(name)
      YAML.load(yaml_contents(name))
    end
    def load_locale(name)
      YamlTranslator::Locale.load_file(yaml_path(name))
    end
  end
end
