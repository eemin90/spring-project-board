package io.github.eemin90.mapper;

import io.github.eemin90.domain.AuthVO;
import io.github.eemin90.domain.MemberVO;

public interface MemberMapper {

	public int insert(MemberVO vo);
	
	public int insertAuth(AuthVO vo);
	
	public MemberVO read(String userid);

	public int update(MemberVO vo);

	public int remove(MemberVO vo);
	
	public int removeAuth(MemberVO vo);
}
