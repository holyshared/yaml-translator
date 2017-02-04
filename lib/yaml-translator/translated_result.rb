require 'yaml'

module YamlTranslator
  class TranslatedResult
    attr_reader :lang, :values

    def initialize(values, lang)
      @lang = lang
      @values = values
    end

    def save_to(dir)
      File.write("#{dir}/#{lang}.yml", YAML.dump(@values))
    end

    def to_s
      @values.to_s
    end
  end
end
