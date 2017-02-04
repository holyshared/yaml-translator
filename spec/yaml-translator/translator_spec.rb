describe YamlTranslator::Translator do
  describe '#translate' do
    let(:translator) { YamlTranslator::Translator.new }
    context 'when have root' do
      let(:yaml_tree) { load_yaml(:with_root) }
      it 'translated tree' do
        translated_tree = translator.translate(yaml_tree)
        expect(translated_tree.values).to eq(yaml_tree)
      end
    end
    context 'when have root' do
      let(:yaml_tree) { load_yaml(:no_root) }
      it 'translated tree' do
        translated_tree = translator.translate(yaml_tree)
        expect(translated_tree.values).to eq(yaml_tree)
      end
    end
  end
end
