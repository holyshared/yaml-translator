require 'yaml-translator/version'
require 'yaml-translator/structure'
require 'yaml-translator/locale'
require 'yaml-translator/context'
require 'yaml-translator/key_path'
require 'yaml-translator/translator'
require 'yaml-translator/adapters'

module YamlTranslator
  class << self
    def load(s)
      Locale.load(s)
    end

    def load_file(file)
      Locale.load_file(file)
    end

    def create(name, options={})
      adapter = Adapters.find_and_create(name, options)
      Translator.new(adapter)
    end
  end
end
