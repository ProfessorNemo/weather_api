# frozen_string_literal: true

RSpec.describe GetClient do
  let(:option_mock) { double('GetClient') }

  let(:location_key) do
    VCR.use_cassette('location_key') { described_class.new.send(:location_key) }
  end

  context 'when update db' do
    let(:create_data) do
      VCR.use_cassette('update_data') { described_class.new.update_data }
    end

    include_examples 'saving data to database'
  end

  context 'when create db' do
    let(:create_data) do
      VCR.use_cassette('create_data') { described_class.new.create_data }
    end

    include_examples 'saving data to database'
  end

  it 'unique city key' do
    expect(location_key).to eq('295212')
  end

  describe '#options' do
    before { allow(described_class).to receive(:new).and_return(option_mock) }
    before do
      allow(option_mock)
        .to receive(:options)
        .and_return({ apikey: 'lkl5kj4gr58t5t5no4if5ar6jc9', q: 'St.Petersburg' })
    end

    it do
      option_mock.options
      expect(option_mock).to have_received(:options)
    end

    it { expect(option_mock.options).to be_a(Hash) }

    it { expect(option_mock.options[:q]).to eq('St.Petersburg') }
  end
end
