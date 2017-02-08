module YamlTranslator
  class Context
    def initialize(locale, translator)
      @locale = locale
      @translator = translator
    end
    def to(lang)
      @translator.translate(@locale, to: lang)
    end
  end
end
