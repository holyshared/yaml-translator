describe YamlTranslator::Adapters::GoogleTranslateAdapter do
  let(:adapter) { YamlTranslator::Adapters::GoogleTranslateAdapter.new(api_key: 'xyz') }
  describe '#translate' do
    context 'when some values' do
      let(:some_values) do
        values = {}
        values['en.foo'] = 'a_b'
        values['en.bar'] = 'b_b'
        values
      end
      before do
        allow(EasyTranslate).to receive(:translate).and_return(['a_a', 'a_b'])
      end
      subject { adapter.translate(some_values, to: :ja) }
      it 'should be return translate results' do
        expect(subject.size).to be 2
        expect(subject['en.foo']).to eq('a_a')
        expect(subject['en.bar']).to eq('a_b')
      end
    end
    context 'when empty values' do
      let(:null_values) { {} }
      before do
        allow(EasyTranslate).to receive(:translate).and_return([])
      end
      subject { adapter.translate(null_values, to: :ja) }
      it 'should be return empty' do
        expect(subject.size).to be 0
      end
    end
  end
end
