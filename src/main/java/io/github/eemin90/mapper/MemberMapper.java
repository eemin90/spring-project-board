package io.github.eemin90.mapper;

import io.github.eemin90.domain.AuthVO;
import io.github.eemin90.domain.MemberVO;

public interface MemberMapper {

	public int insert(MemberVO vo);
	
	public int insertAuth(AuthVO vo);
	
	public MemberVO read(String userid);
}
