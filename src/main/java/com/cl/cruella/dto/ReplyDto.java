package com.cl.cruella.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class ReplyDto {
    private int replyNo;
    private String replyContent;
    private String memNo; 
    private int boardNo;
    private int replyType;
    private String replyRegistDT;
    private String replyModifyDT;
    private int replyRef;
    private String memName;
    private String profileURL;
}
