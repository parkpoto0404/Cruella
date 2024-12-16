package com.cl.cruella.controller;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.cl.cruella.dto.MessageDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MessageController {

	/*
	@MessageMapping("/chat/{chatNo}")
	@SendTo("/sub/chat/{chatNo}")
	public String message(@DestinationVariable Long chatNo, @Payload MessageDto message) {
		log.debug("chatNo:{}, message: {} ",chatNo,message.getMsgContent());
		
		return message.getMsgContent();
		
	}
	*/
}
