describe YamlTranslator::Translator do
  let(:translator) { YamlTranslator::Translator.new }
  describe '#translate' do
    context 'when have root' do
      let(:yaml_tree) { load_yaml(:with_root) }
      let(:locale) { YamlTranslator::Locale.new(yaml_tree, :en) }
      it 'translated tree' do
        translated_locale = translator.translate(locale)
        expect(translated_locale.values).to eq(locale.values)
      end
    end
    context 'when have root' do
      let(:yaml_tree) { load_yaml(:no_root) }
      let(:locale) { YamlTranslator::Locale.new(yaml_tree, :en) }
      it 'translated tree' do
        translated_locale = translator.translate(locale)
        expect(translated_locale.values).to eq(locale.values)
      end
    end
  end
  describe '#file' do
    let(:path) { yaml_path(:en) }
    let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
    it 'translate files' do
      result = translator.file(path).to(:en)
      expect(result.values).to eq(expected_locale.values)
    end
  end
  describe '#string' do
    let(:yaml_source) { yaml_contents(:en) }
    let(:expected_locale) { YamlTranslator::Locale.load(yaml_source) }
    it 'translate yaml string' do
      result = translator.string(yaml_source).to(:en)
      expect(result.values).to eq(expected_locale.values)
    end
  end
end
