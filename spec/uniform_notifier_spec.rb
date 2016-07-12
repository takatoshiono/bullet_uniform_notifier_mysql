require 'spec_helper'

describe UniformNotifier do
  describe '.active_notifiers' do
    before do
      allow(UniformNotifier::Mysql).to receive(:active?).and_return(true)
    end

    subject { UniformNotifier.active_notifiers }

    it { is_expected.to eq [UniformNotifier::Mysql] }
  end
end
