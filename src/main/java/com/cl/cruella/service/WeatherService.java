package com.cl.cruella.service;

import java.util.Map;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WeatherService {

	private final RestTemplate restTemplate;
	private final String apiKey = "eaceecab3b2db46d79492a95015c1cff";
	private final String apiUrl = "https://api.openweathermap.org/data/2.5/weather";
	
	public WeatherService(RestTemplateBuilder builder) {
		this.restTemplate = builder.build();
	}
	
	// 영어 조건을 한글로 변환하는 메서드
	private String translateWeatherCondition(String englishCondition) {
		switch (englishCondition.toLowerCase()) {
		case "clear sky": return "/assets/img/weather/clearSky.png";
		case "few clouds": return "/assets/img/weather/cloud_little.png";
		case "scattered clouds": return "/assets/img/weather/cloud_little.png";
		case "broken clouds": return "/assets/img/weather/cloud.png";
		case "shower rain": return "/assets/img/weather/rain.png";
		case "rain": return "/assets/img/weather/rain.png";
		case "thunderstorm": return "/assets/img/weather/rain.png";
		case "snow": return "/assets/img/weather/snow.png";
		case "mist": return "/assets/img/weather/cloud.png";
		case "light rain": return "/assets/img/weather/rain.png";
		case "light snow": return "/assets/img/weather/snow.png";
		case "light rain and snow": return "/assets/img/weather/snow.png";
		// 다른 경우도 추가 가능
		default: return "/assets/img/weather/cloud_little.png";
		}
    }
	
    // 날씨 API 호출
    public Map<String, Object> getWeather(String city) {
        String url = apiUrl + "?q=" + city + "&appid=" + apiKey + "&units=metric";
        Map<String, Object> weather = restTemplate.getForObject(url, Map.class);
        
        // 영어로 되어 있는 날씨 조건을 한글로 변경
        if (weather != null && weather.get("weather") != null) {
            String condition = ((Map<String, String>) ((java.util.List) weather.get("weather")).get(0)).get("description");
            String koreanCondition = translateWeatherCondition(condition);
            ((Map<String, String>) ((java.util.List) weather.get("weather")).get(0)).put("description", koreanCondition);
        }

        return weather;
    }
}
