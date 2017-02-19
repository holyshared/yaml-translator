describe YamlTranslator::Translator do
  let(:translator) { YamlTranslator::Translator.new }
  describe '#file' do
    context 'when ja' do
      let(:path) { yaml_path(:ja) }
      let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
      it 'translate files' do
        result = translator.file(path).to(:ja)
        expect(result.lang).to eq(:ja)
        expect(result.config).to eq(expected_locale.config)
      end
    end
    context 'when zh-CN' do
      let(:path) { yaml_path(:'zh-CN') }
      let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
      it 'translate files' do
        result = translator.file(path).to(:'zh-CN')
        expect(result.lang).to eq(:'zh-CN')
        expect(result.config).to eq(expected_locale.config)
      end
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
        expect(result.config).to eq(expected_locale.config)
      end
    end
    context 'when zh-CN' do
      let(:path) { yaml_path(:'zh-CN') }
      let(:expected_locale) { YamlTranslator::Locale.load_file(path) }
      it 'translate yaml string' do
        result = translator.string(yaml_source).to(:'zh-CN')
        expect(result.lang).to eq(:'zh-CN')
        expect(result.config).to eq(expected_locale.config)
      end
    end
  end
  describe '#diff' do
    let(:yaml_source) { yaml_contents(:en) }
    context 'when diff nothing' do
      context 'when ja' do
        subject { translator.string(yaml_source).diff(yaml_source).to(:ja) }
        it 'translate yaml string' do
          expect(subject.lang).to eq(:ja)
        end
      end
    end
  end
end
