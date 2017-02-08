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
      s = to_single_key_hash
      o = locale.to_single_key_hash
      Locale.new(s.merge(o).to_tree, lang)
    end

    def merge_to(locale)
      locale.merge(self)
    end

    def merge_to_file(file)
      target_locale = Locale.load_file(file)
      target_locale.merge(self)
    end

    def merge_to_s(s)
      target_locale = Locale.load(s)
      target_locale.merge(self)
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
      def load(s)
        yaml = YAML.load(s)
        lang = yaml.keys.first # FIXME check support language
        self.new(yaml, lang)
      end

      def load_file(file)
        load(File.open(file, &:read))
      end
    end

    private

    def write_file(file_path)
      File.write(file_path, to_s)
    end
  end
end
