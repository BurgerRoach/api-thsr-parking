# Taiwan High Speed Rail (THSR) real-time parking space enquiry service

This is a real time inquiry service for Taiwan High Speed Rail (HSR) parking spaces. 

Although it is just a small program, it should save the life of THSRers!

## Domain Language

**AvailableSpaces** (Domain) → **service_available_level** (Language)

## Status

[![Ruby v2.7.1](https://img.shields.io/badge/Ruby-2.7.1-green)](https://www.ruby-lang.org/en/news/2020/03/31/ruby-2-7-1-released/)

## Requirements

* JSON
* Minitest

## Get Started

* #### Test 

```bash
rake spec
```

* #### Call API

Create an object to receive API data.

```ruby
api = THSR::Api.new
```

* #### Search all park

```ruby
data = api.search
```


Part of return : 

```ruby
{"UpdateTime"=>"2020-10-16T19:13:57+08:00", "ParkingAvailabilities"=>[{"CarParkID"=>"2100", "CarParkName"=>"高鐵桃園站戶外短期停車場(P1)", "TotalSpaces"=>46, "AvailableSpaces"=>30, "ServiceStatus"=>1, "FullStatus"=>0, "ChargeStatus"=>1, "DataCollectTime"=>"2020-10-16T19:13:12+08:00"}, {"CarParkID"=>"2200", "CarParkName"=>"高鐵桃園站戶外短期停車場(P2)", "TotalSpaces"=>55, "AvailableSpaces"=>18, "ServiceStatus"=>1, "FullStatus"=>0, "ChargeStatus"=>1, "DataCollectTime"=>"2020-10-16T19:13:12+08:00"},...]}
```

* #### Search park by option

```ruby
opts = {
  'service_status': 1,
  'service_available_level': 60,
  'charge_status': 1
}
data = api.search(opts)
```

`service_status` : Parking lot business status: [0:'Closed', 1:'Opening', 2:'Closed']

`service_available_level` : Vacancy remain

`charge_status` : Parking charge status: [0:'No charge', 1:'Normal charge', 2:'Suspended charge']


* #### Search park by City

```ruby
city = '苗栗'
park = api.search_by_city(city)
```

Return wii be like:

```ruby
{"UpdateTime"=>"2020-10-17T16:06:57+08:00", "ParkingAvailabilities"=>[{"CarParkID"=>"2500", "CarParkName"=>"高鐵苗栗站戶外平面停車場(P1)", "TotalSpaces"=>449, "AvailableSpaces"=>290, "ServiceStatus"=>1, "FullStatus"=>0, "ChargeStatus"=>1, "DataCollectTime"=>"2020-10-17T16:06:12+08:00"}]}
```

* #### Search park by Park_ID

```ruby
park = api.search_by_park_id(id)
```

Return wii be like:

```ruby
{"UpdateTime"=>"2020-10-16T19:13:57+08:00", "CarParkID"=>"2500", "CarParkName"=>"高鐵苗栗站戶外平面停車場(P1)", "TotalSpaces"=>449, "AvailableSpaces"=>327, "ServiceStatus"=>1, "FullStatus"=>0, "ChargeStatus"=>1, "DataCollectTime"=>"2020-10-16T19:13:12+08:00"}
```

## Document

*class* Api

* `search(option)`
  * option *hash*: Your condiition

* `search_by_city(city)`
  * city name: must be string

* `search_by_park_id(id)`
  * id *string* : it must be a 4-digit string

## License

2020, Ching-Hsuan Su 蘇靖軒

2020, Jonathan Wu 吳則賢

2020, Shin-Chi Kuo 郭士齊