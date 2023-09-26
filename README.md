# Whether, Sweater?

### Project Description

You are a back-end developer working on a team that is building an application to plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination.

Your team is working in a service-oriented architecture. The front-end will communicate with your back-end through an API. Your job is to expose that API that satisfies the front-end team’s requirements.

### Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).


### Links
- [Project Overview (Turing)](https://backend.turing.edu/module3/projects/sweater_weather/index)
- [Project Requirements (Turing)](https://backend.turing.edu/module3/projects/sweater_weather/requirements)
- [Project Rubric (Turing)](https://backend.turing.edu/module3/projects/sweater_weather/rubric)


## API Endpoints

### `GET` Forecast

#### Resource URL

```
/api/v1/forecast
```

#### Query Paramaters

| Param | Data Type | Description | Example|
|---|---|---|---|
| **location** | _string_ | A string of a city and state | `?location=denver,co` |

#### Responses

<details>

<summary>🟢 200: Successful Response</summary>

**Request**

```
GET /api/v0/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

**Response**

```json
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-09-25 23:00",
        "temperature": 58.6,
        "feels_like": 59.7,
        "humidity": 28,
        "uvi": 1.0,
        "visibility": 9.0,
        "condition": "Clear",
        "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
      },
      "daily_weather": [
        {
          "date": "2023-09-25",
          "sunrise": "06:50 AM",
          "sunset": "06:52 PM",
          "max_temp": 82.6,
          "min_temp": 49.8,
          "condition": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "date": "2023-09-26",
          "sunrise": "06:51 AM",
          "sunset": "06:51 PM",
          "max_temp": 86.2,
          "min_temp": 52.5,
          "condition": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "date": "2023-09-27",
          "sunrise": "06:52 AM",
          "sunset": "06:49 PM",
          "max_temp": 86.3,
          "min_temp": 62.8,
          "condition": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "date": "2023-09-28",
          "sunrise": "06:53 AM",
          "sunset": "06:47 PM",
          "max_temp": 88.9,
          "min_temp": 63.7,
          "condition": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "date": "2023-09-29",
          "sunrise": "06:54 AM",
          "sunset": "06:46 PM",
          "max_temp": 86.7,
          "min_temp": 64.2,
          "condition": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        }
      ],
      "hourly_weather": [
        {
          "time": "00:00",
          "temperature": 60.4,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "01:00",
          "temperature": 62.7,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "02:00",
          "temperature": 61.7,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "03:00",
          "temperature": 53.4,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "04:00",
          "temperature": 59.9,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "05:00",
          "temperature": 59.3,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "06:00",
          "temperature": 49.8,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "07:00",
          "temperature": 58.2,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "08:00",
          "temperature": 60.3,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "09:00",
          "temperature": 61.2,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "10:00",
          "temperature": 68.8,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "11:00",
          "temperature": 72.3,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "12:00",
          "temperature": 78.8,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "13:00",
          "temperature": 77.9,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "14:00",
          "temperature": 79.2,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "15:00",
          "temperature": 82.6,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "16:00",
          "temperature": 81.1,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "17:00",
          "temperature": 80.5,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "18:00",
          "temperature": 80.6,
          "conditions": "Sunny",
          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "19:00",
          "temperature": 74.5,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "20:00",
          "temperature": 72.4,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "21:00",
          "temperature": 69.6,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "22:00",
          "temperature": 69.8,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "23:00",
          "temperature": 58.6,
          "conditions": "Clear",
          "icon": "cdn.weatherapi.com/weather/64x64/night/113.png"
        }
      ]
    }
  }
}
```
</details>