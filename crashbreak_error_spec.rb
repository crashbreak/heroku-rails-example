describe 'error id: 54', type: :request do

  let(:restorers_data) { StateRestorer.new('54').restore }
  let(:request_parser) { Crashbreak::RequestParser.new restorers_data[:request] }

  it 'sends request' do
    request_parser.request_data do |request_method, url, body, headers|
      method(request_method).call url, body, headers
    end
  end
end
