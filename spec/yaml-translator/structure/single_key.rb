describe YamlTranslator::Structure::SingleKey do
  let(:tree) { { en: { foo: 'bar' } } }
  describe '#to_single_key' do
    it 'should be return single key hash' do
      expect(tree.to_single_key).to eq({ 'en.foo' => 'bar' })
    end
  end
end
