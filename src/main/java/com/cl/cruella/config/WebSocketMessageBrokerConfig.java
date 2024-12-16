package com.cl.cruella.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;


import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketMessageBrokerConfig implements WebSocketMessageBrokerConfigurer{
	
	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/chatPage") // 연결할 엔드포인트
				.setAllowedOriginPatterns("*")	// 모든 도메인 접근 허용
				.withSockJS();
	}
	
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		registry.setApplicationDestinationPrefixes("/pub");		// 메시지 발행 요청 url 메시지 보낼때
		registry.enableSimpleBroker("/sub");					// 메시지 구독 요청 url 메시지 받을떄
	}
	
	
}
