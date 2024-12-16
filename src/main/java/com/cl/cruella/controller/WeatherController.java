package com.cl.cruella.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cl.cruella.service.WeatherService;

@RestController
public class WeatherController {
	
    private final WeatherService weatherService;
    
    public WeatherController(WeatherService weatherService) {
        this.weatherService = weatherService;
    }
    
    // 날씨 API AJAX 요청 처리
    @GetMapping("/api/weather")
    public Map<String, Object> getWeather(@RequestParam String city) {
        return weatherService.getWeather(city);
    }

}
