require 'rspec/temp_dir'

describe YamlTranslator do
  describe '#create' do
    context 'when google translate adapter' do
      it 'should be load translator' do
        translator = YamlTranslator.create(:google_translate, api_key: 'xyz')
        expect(translator).to be_kind_of(YamlTranslator::Translator)
        expect(translator.adapter_name).to eq(:google_translate)
      end
    end
    context 'when noop adapter' do
      it 'should be load translator' do
        translator = YamlTranslator.create(:noop)
        expect(translator).to be_kind_of(YamlTranslator::Translator)
        expect(translator.adapter_name).to eq(:noop)
      end
    end
  end
end
