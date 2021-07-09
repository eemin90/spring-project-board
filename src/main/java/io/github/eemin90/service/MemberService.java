package io.github.eemin90.service;

import io.github.eemin90.domain.MemberVO;

public interface MemberService {

	boolean insert(MemberVO vo);

	MemberVO read(String name);

	boolean modify(MemberVO vo);

	boolean remove(MemberVO vo);

	boolean remove(MemberVO vo, String oldPassword);

	boolean modify(MemberVO vo, String oldPassword);

}
