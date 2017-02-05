require 'rspec/temp_dir'

describe YamlTranslator::Locale do
  include_context 'uses temp dir'

  let(:tmp_dir) { temp_dir }
  let(:lang_file) { File.join(File.dirname(__FILE__), '/../fixtures/en.yml') }
  let(:lang_file_content) { File.open(lang_file, &:read) }
  let(:locale) { YamlTranslator::Locale.load_file(lang_file) }
  let(:output_file) { File.join(tmp_dir, 'en.yml') }
  let(:file_exist) { File.exist?(output_file) }

  describe '#flatten_hash' do
    let(:flatten_hash) do
      {
        'en.bar' => 'bar',
        'en.foo'=> 'foo',
        'en.foo1.foo1' => 'foo1-1',
        'en.foo1.foo2' => 'foo1-2'
      }
    end
    it 'should be return flatten hash' do
      expect(locale.flatten_hash).to eq(flatten_hash)
    end
  end
  describe '#to_s' do
    it 'should be return yaml formatted string' do
      expect(locale.to_s).to eq(lang_file_content)
    end
  end
  describe '#save_to' do
    before { locale.save_to(tmp_dir) }
    it 'should be write a language file' do
      expect(file_exist).to be true
    end
  end
end
