# API of Taiwan High Speed Rail (THSR) real-time parking space enquiry service 

These are the APIs of the real time inquiry service for Taiwan High Speed Rail (HSR) parking spaces. 

## Restful API

- v1URL = https://thsr-parking-api.herokuapp.com/api/v1

- Status code

  | Status Code | Description         |
  | ----------- | ------------------- |
  | 200         | OK                  |
  | 400         | Bad Request         |
  | 404         | Not Found           |
  | 503         | Service Unavailable |

- CityAPI

  | API Method | API URL                 | Desc                       | Req Params | Resp Result                        |
  | ---------- | ----------------------- | -------------------------- | ---------- | ---------------------------------- |
  | GET        | v1URL/cities            | List all cities info       |            |                                    |
  | GET        | v1URL/cities?city_name= | Get city info by City Name | City Name  | City_id, name, latitude, longitude |
  | GET        | v1URL/cities?city_id=   | Get city info by City ID   | City ID    | City_id, name, latitude, longitude |
  
  - Success Response
  
    - url:  https://thsr-parking-api.herokuapp.com/api/v1/cities
  
    - Code: 200
  
    - Content: 
  
      ```json
      {
        "cities":[
          {"city_id":"1","name":"桃園","latitude":"25.01309","longitude":"121.2152"},
          {"city_id":"2","name":"新竹","latitude":"24.80806","longitude":"121.0404"},
          {"city_id":"3","name":"苗栗","latitude":"24.60851","longitude":"120.8269"},
          {"city_id":"4","name":"台中","latitude":"24.11365","longitude":"120.6157"},
          {"city_id":"5","name":"彰化","latitude":"23.87432","longitude":"120.5724"},
          {"city_id":"6","name":"雲林","latitude":"23.73628","longitude":"120.4143"},
          {"city_id":"7","name":"嘉義","latitude":"23.45551","longitude":"120.3229"},
          {"city_id":"8","name":"台南","latitude":"22.92564","longitude":"120.2863"},
          {"city_id":"9","name":"高雄","latitude":"22.67709","longitude":"120.3074"}
      	]
      }
      ```

## License

2020, Ching-Hsuan Su 蘇靖軒

2020, Jonathan Wu 吳則賢

2020, Shin-Chi Kuo 郭士齊