package io.github.eemin90.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import io.github.eemin90.domain.AuthVO;
import io.github.eemin90.domain.MemberVO;
import io.github.eemin90.mapper.BoardMapper;
import io.github.eemin90.mapper.FileMapper;
import io.github.eemin90.mapper.MemberMapper;
import io.github.eemin90.mapper.ReplyMapper;
import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper	replyMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = @Autowired)
	private FileMapper fileMapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	@Override
	@Transactional
	public boolean insert(MemberVO vo) {
		// 패스워드 암호화
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		int cnt = mapper.insert(vo);
		
		AuthVO avo = new AuthVO();
		avo.setUserid(vo.getUserid());
		avo.setAuth("ROLE_USER");
		mapper.insertAuth(avo);
		
		return cnt == 1;
	}

	@Override
	public MemberVO read(String name) {
		return mapper.read(name);
	}

	@Override
	public boolean modify(MemberVO vo) {
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		
		int cnt = mapper.update(vo);
		
		return cnt == 1;
	}

	@Override
	public boolean remove(MemberVO vo) {
		// tbl_reply 삭제
		replyMapper.removeByUserid(vo);
		// tbl_board_file 삭제
		fileMapper.removeByUserid(vo);
		// tbl_board 삭제
		boardMapper.removeByUserid(vo);
		// tbl_member_auth 삭제
		mapper.removeAuth(vo);
		// tbl_member 삭제
		int cnt = mapper.remove(vo);
		return cnt == 1;
	}

}
