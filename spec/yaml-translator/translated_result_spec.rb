require 'rspec/temp_dir'

describe YamlTranslator::TranslatedResult do
  let(:result) { YamlTranslator::TranslatedResult.new({ foo: 'bar' }, 'ja') }
  describe '#save_to' do
    let(:tmp_dir) { temp_dir }
    let(:output_file) { File.join(tmp_dir, 'ja.yml') }
    let(:file_exist) { File.exist?(output_file) }
    include_context 'uses temp dir'
    it 'should be write a language file' do
      result.save_to(tmp_dir)
      expect(file_exist).to be true
    end
  end
end
