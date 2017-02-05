require 'yaml'

module YamlTranslator
  class Locale
    attr_reader :lang, :values

    def initialize(values, lang)
      @lang = lang
      @values = values
    end

    def translate(translator, options={})
      translator.translate(self, options)
    end

    def save(dir=Dir.pwd)
      write_file(File.join(dir, "#{lang}.yml"))
    end

    def save_to(dir)
      save(dir)
    end

    def flatten_hash
      flatten(values)
    end

    def to_s
      YAML.dump(values)
    end

    class << self
      def load_file(file)
        lang = File.basename(file).gsub(/.(yml|yaml)/, '')
        yaml = YAML.load(File.open(file, &:read))
        self.new(yaml, lang)
      end
    end

    private

    # Covert to a flatten hash
    def flatten(values={}, path=KeyPath.new)
      result = {}
      values.each_with_index do |(i, v)|
        path.move_to(i)
        if v.is_a?(Hash)
          result.merge!(flatten(v, path))
        else
          result[path.to_s] = v
        end
        path.leave
      end
      result
    end

    def write_file(file_path)
      File.write(file_path, to_s)
    end
  end
end
