describe YamlTranslator::Translator do
  let(:translator) { YamlTranslator::Translator.new }
  describe '#file' do
    let(:path) { yaml_path(:ja) }
    let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
    it 'translate files' do
      result = translator.file(path).to(:ja)
      expect(result.lang).to eq(:ja)
      expect(result.values).to eq(expected_locale.values)
    end
  end
  describe '#string' do
    let(:yaml_source) { yaml_contents(:en) }
    context 'when ja' do
      let(:path) { yaml_path(:ja) }
      let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
      it 'translate yaml string' do
        result = translator.string(yaml_source).to(:ja)
        expect(result.lang).to eq(:ja)
        expect(result.values).to eq(expected_locale.values)
      end
    end
    context 'when zh-CN' do
      let(:path) { yaml_path(:'zh-CN') }
      let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
      it 'translate yaml string' do
        result = translator.string(yaml_source).to(:'zh-CN')
        expect(result.lang).to eq(:'zh-CN')
        expect(result.values).to eq(expected_locale.values)
      end
    end
  end
end
