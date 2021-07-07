package io.github.eemin90.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private String writerName;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
	
	private String fileName;
}
