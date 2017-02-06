require 'yaml'
require 'diff/lcs'

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

    def diff(other)
      before_seq = to_single_key_hash.map { |k, v| "#{k}: #{v}" }
      after_seq = other.to_single_key_hash.map { |k, v| "#{k}: #{v}" }
      diffs = Diff::LCS.diff(before_seq, after_seq).flatten.map do |operation|
        type, position, element = *operation
        next if type == '-'
        key, text = *element.split(':')
        [key, text.strip]
      end
      single_key_hash = Hash[diffs.compact]
      Locale.new(single_key_hash.to_tree, lang)
    end

    def merge(locale)
      merged = flatten_hash.merge(locale.flatten_hash)
      Locale.new(merged.to_tree, lang)
    end

    def save(dir=Dir.pwd)
      write_file(File.join(dir, "#{lang}.yml"))
    end

    def save_to(dir)
      save(dir)
    end

    def to_single_key_hash
      values.to_single_key
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

    def write_file(file_path)
      File.write(file_path, to_s)
    end
  end
end
