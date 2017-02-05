describe YamlTranslator::Translator do
  describe '#translate' do
    let(:translator) { YamlTranslator::Translator.new }
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
end
