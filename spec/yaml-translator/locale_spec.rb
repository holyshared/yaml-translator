require 'rspec/temp_dir'

describe YamlTranslator::Locale do
  include_context 'uses temp dir'

  let(:tmp_dir) { temp_dir }
  let(:lang_file) { File.join(File.dirname(__FILE__), '/../fixtures/en.yml') }
  let(:lang_file_content) { File.open(lang_file, &:read) }
  let(:locale) { YamlTranslator::Locale.load_file(lang_file) }
  let(:output_file) { File.join(tmp_dir, 'en.yml') }
  let(:file_exist) { File.exist?(output_file) }

  describe '#diff' do
    let(:before_locale) { load_locale('diff/before/en') }
    let(:after_locale) { load_locale('diff/after/en') }
    let(:single_key_hash) do
      {
        'en.foo1.foo3' => 'foo1-3'
      }
    end
    it 'should be return flatten hash' do
      diff_locale = before_locale.diff(after_locale)
      expect(diff_locale.lang).to eq('en')
      expect(diff_locale.to_single_key_hash).to eq(single_key_hash)
    end
  end

  describe '#to_single_key_hash' do
    let(:single_key_hash) do
      {
        'en.bar' => 'bar',
        'en.foo'=> 'foo',
        'en.foo1.foo1' => 'foo1-1',
        'en.foo1.foo2' => 'foo1-2'
      }
    end
    it 'should be return flatten hash' do
      expect(locale.to_single_key_hash).to eq(single_key_hash)
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
