require 'rspec/temp_dir'

describe YamlTranslator::Locale do
  include_context 'uses temp dir'

  let(:tmp_dir) { temp_dir }
  let(:lang_file) { File.join(File.dirname(__FILE__), '/../fixtures/en.yml') }
  let(:lang_file_content) { File.open(lang_file, &:read) }
  let(:locale) { YamlTranslator::Locale.load_file(lang_file) }
  let(:output_file) { File.join(tmp_dir, 'en.yml') }
  let(:file_exist) { File.exist?(output_file) }

  describe '#load' do
    it 'should be load from string' do
      locale = YamlTranslator::Locale.load(lang_file_content)
      expect(locale.lang).to eq(:en)
    end
  end

  describe '#diff' do
    let(:before_locale) { load_locale('diff/before/en') }
    let(:after_locale) { load_locale('diff/after/en') }
    let(:single_key_hash) do
      {
        'en.foo1.foo3' => 'foo1-3',
      }
    end
    it 'should be return flatten hash' do
      diff_locale = before_locale.diff(after_locale)
      expect(diff_locale.lang).to eq(:en)
      expect(diff_locale.to_single_key_hash).to eq(single_key_hash)
    end
  end

  describe '#to_single_key_hash' do
    let(:single_key_hash) do
      {
        'en.bar' => 'bar',
        'en.foo' => 'foo',
        'en.foo1.foo1' => 'foo1-1',
        'en.foo1.foo2' => 'foo1-2',
      }
    end
    it 'should be return flatten hash' do
      expect(locale.to_single_key_hash).to eq(single_key_hash)
    end
  end

  describe '#merge_to_file' do
    let(:merge_target_file) { File.join(File.dirname(__FILE__), '/../fixtures/merge_target.yml') }
    it 'should be merge to yaml file' do
      merged = locale.merge_to_file(merge_target_file)
      expect(merged['en']['target']).to eq('bar')
    end
  end

  describe '#merge_to_s' do
    it 'should be merge to yaml formatted string' do
      merged = locale.merge_to_s("---\nen:\n  merge_to_s: ok?")
      expect(merged['en']['merge_to_s']).to eq('ok?')
    end
  end

  describe '#to_s' do
    it 'should be return yaml formatted string' do
      expect(locale.to_s).to eq(lang_file_content)
    end
  end
  describe '#save_to' do
    context 'when default' do
      before { locale.save_to(tmp_dir) }
      it 'should be write a language file' do
        expect(file_exist).to be true
      end
    end
    context 'when with prefix option' do
      let(:output_file) { File.join(tmp_dir, 'ns.en.yml') }
      let(:file_exist) { File.exist?(output_file) }
      before { locale.save_to(tmp_dir, prefix: 'ns.') }
      it 'should be write a language file' do
        expect(file_exist).to be true
      end
    end
  end
end
