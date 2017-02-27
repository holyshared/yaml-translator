require 'yaml'
require 'psych'
require 'ostruct'
require 'diff/lcs'

module YamlTranslator
  class Locale < OpenStruct
    attr_reader :lang

    class << self
      def load(s)
        self.new(YAML.load(s))
      end

      def load_file(file)
        load(File.open(file, &:read))
      end
    end

    def initialize(config)
      super(config)
      @lang = config.keys.first.to_sym # FIXME check support language
    end

    def locale_texts
      self[lang]
    end

    def translate(translator, options={})
      translated_values = translator.translate(compact_of(locale_texts), options)
      Locale.new(Hash[*[options[:to], tree_of(translated_values)]])
    end

    def diff(other_locale)
      before_seq = to_single_key_hash.map { |k, v| "#{k}: #{v}" }
      after_seq = other_locale.to_single_key_hash.map { |k, v| "#{k}: #{v}" }
      diffs = Diff::LCS.diff(before_seq, after_seq).flatten.map do |operation|
        type, position, element = *operation
        next if type == '-'
        key, text = *element.split(':')
        [key, text.strip]
      end
      tree_hash = tree_of(Hash[diffs.compact])
      tree_hash[lang] = {} if tree_hash.empty?
      Locale.new(tree_hash)
    end

    def merge(other_locale)
      s = to_single_key_hash
      o = other_locale.to_single_key_hash
      Locale.new(tree_of(s.merge(o)))
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

    # Save the file
    #
    # @param dir [String] Directory path to save the file
    # @param options [Hash] Options for saving
    # @return int
    def save(dir=Dir.pwd, options={})
      prefix = options[:prefix] if options.key?(:prefix)
      write_file(File.join(dir, "#{prefix}#{lang}.yml"), options)
    end

    def save_to(dir, options={})
      save(dir, options)
    end

    # Covert to a flatten hash
    def to_single_key_hash
      compact_of(to_h, KeyPath.new)
    end

    def to_s
      to_yaml
    end

    def to_yaml(options={})
      Hash[*[lang.to_s, locale_texts]].to_yaml(options)
    end

    private

    # Covert to a flatten hash
    def compact_of(values={}, path=KeyPath.new)
      result = {}
      values.each_with_index do |(i, v)|
        path.move_to(i)
        if v.is_a?(Hash)
          result.merge!(compact_of(v, path))
        else
          result[path.to_s] = v
        end
        path.leave
      end
      result
    end

    # Returning the flattened structure to the tree structure
    #
    # @param [Hash] values flatten Hash
    # @return [Hash] translated hash
    def tree_of(values)
      result = {}
      current = result
      values.each do |k, v|
        keys = k.to_s.split('.')
        last_key = keys.pop
        keys.each do |ks|
          current = if current.key?(ks)
                      current[ks]
                    else
                      current[ks] = {}
                      current[ks]
                    end
        end
        current[last_key] = v
        current = result
      end
      result
    end

    def write_file(file_path, options={})
      File.write(file_path, to_yaml(options))
    end
  end
end
