describe YamlTranslator::Structure::Tree do
  let(:single_key) { { 'en.foo' => 'bar' } }
  describe '#to_tree' do
    it 'should be return tree hash' do
      expect(single_key.to_tree.to_s).to eq({ 'en' => { 'foo' => 'bar' } }.to_s)
    end
  end
end
