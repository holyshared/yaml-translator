module YamlTranslator
  class Context
    def initialize(locale, translator)
      @locale = locale
      @translator = translator
    end

    def to(target)
      @locale.translate(@translator, to: target)
    end

    def all(targets)
      targets.map { |target| @locale.translate(@translator, to: target) }
    end
  end

  class FileContext < Context
    def diff(path)
      diff_locale = @locale.diff(Locale.load_file(path))
      DiffContext.new(diff_locale, @translator)
    end
  end

  class StringContext < Context
    def diff(s)
      diff_locale = @locale.diff(Locale.load(s))
      DiffContext.new(diff_locale, @translator)
    end
  end

  class DiffContext < Context
  end
end
