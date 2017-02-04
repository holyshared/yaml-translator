require 'yaml'

module YamlTranslator
  class TranslatedResult
    attr_reader :lang, :values

    def initialize(values, lang)
      @lang = lang
      @values = values
    end

    def save(dir=Dir.pwd)
      write_file(File.join(dir, "#{lang}.yml"))
    end

    def save_to(dir)
      save(dir)
    end

    def to_s
      YAML.dump(@values)
    end

    private

    def write_file(file_path)
      File.write(file_path, to_s)
    end
  end
end
