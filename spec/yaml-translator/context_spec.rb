describe YamlTranslator::Context do
  let(:lang_file) { File.join(File.dirname(__FILE__), '/../fixtures/en.yml') }
  let(:locale) { YamlTranslator::Locale.load_file(lang_file) }
  let(:adapter) { YamlTranslator::Adapters::NoopAdapter.new }
  let(:translator) { YamlTranslator::Translator.new(adapter) }

  describe '#all' do
    let(:context) { YamlTranslator::Context.new(locale, translator) }
    subject { context.all(%w(ja en)) }
    it 'should be translate all' do
      expect(subject.size).to eq(2)
      expect(subject[0].lang).to eq(:ja)
      expect(subject[1].lang).to eq(:en)
    end
  end
end
