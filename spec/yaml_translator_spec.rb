require 'rspec/temp_dir'

describe YamlTranslator do
  describe '#create' do
    it 'should be load translator' do
      translator = YamlTranslator.create(:google_translate, api_key: 'xyz')
      expect(translator).to be_kind_of(YamlTranslator::Translator)
    end
  end
end
