require_relative 'config/environment'
require_relative 'app/init'

PTX_APP_ID = 'cb149a29eadb481c9d100e7338f935ee'
PTX_APP_KEY = 'H9BTh6__DTND8EOKgCeOtxnkpxg'

result = THSRParking::THSRTime::Api.new(PTX_APP_ID, PTX_APP_KEY).search('1030', nil, '2021-01-06')
puts result


# r = THSRParking::THSR::Api.new.search
# puts r