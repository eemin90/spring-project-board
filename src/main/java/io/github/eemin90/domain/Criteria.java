package io.github.eemin90.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 10); // pageNum 1, amount 10으로 초기화
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getFrom() {
		return amount * (pageNum - 1);
	}
	
	public String[] getTypeArr() {
		if (type == null) {
			return new String[] {}; // type이 null이면 빈 배열 return
		} else {
			String[] types = type.split("");
			return types;
		}
	}
}
