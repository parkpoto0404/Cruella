package com.cl.cruella.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.cl.cruella.handler.ChatEchoHandler;
import com.cl.cruella.handler.ChatEchoHandler2;

import lombok.RequiredArgsConstructor;


@EnableWebSocket
@Configuration
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer{

	private final ChatEchoHandler chatEchoHandler;
	private final ChatEchoHandler2 chatEchoHandler2;
	

	
	@Bean
	HttpSessionHandshakeInterceptor httpSessionHandshackInterceptor() {
		return new HttpSessionHandshakeInterceptor();
	}
	
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		registry.addHandler(chatEchoHandler, "/chat").setAllowedOriginPatterns("*").addInterceptors(httpSessionHandshackInterceptor()).withSockJS();
		registry.addHandler(chatEchoHandler2, "/cruella/*").setAllowedOriginPatterns("*").addInterceptors(httpSessionHandshackInterceptor()).withSockJS();
		
	}
	

}
