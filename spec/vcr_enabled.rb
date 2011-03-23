require 'vcr'
require 'webmock'

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.stub_with :webmock # :fakeweb
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
