require 'spec_helper'

describe UniformNotifier::Mysql do
  let(:mysql_client_mock) { double('Mysql client') }

  before do
    allow(UniformNotifier::Mysql).to receive(:mysql_client).and_return(mysql_client_mock)
    allow(mysql_client_mock).to receive(:query)
  end

  context 'not enabled' do
    it 'should not notify mysql' do
      expect(mysql_client_mock).not_to receive(:prepare)
      expect(UniformNotifier::Mysql.out_of_channel_notify(title: 'notify mysql')).to be_nil
    end
  end

  context 'enabled' do
    let(:statement_mock) { double('Mysql2 statement') }

    before do
      UniformNotifier.mysql = { host: 'localhost', username: 'root', database: 'test' }
    end

    it 'should be active' do
      expect(UniformNotifier::Mysql.active?).to be_truthy
    end

    it 'should notify mysql' do
      expect(mysql_client_mock).to receive(:prepare).and_return(statement_mock)
      expect(statement_mock).to receive(:execute).and_return('executed')
      expect(UniformNotifier::Mysql.out_of_channel_notify(title: 'notify mysql')).to eq 'executed'
    end
  end
end
