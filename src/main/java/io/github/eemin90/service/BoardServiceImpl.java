package io.github.eemin90.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import io.github.eemin90.domain.BoardVO;
import io.github.eemin90.domain.Criteria;
import io.github.eemin90.mapper.BoardMapper;
import io.github.eemin90.mapper.ReplyMapper;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	private ReplyMapper replyMapper;
	
//	@Autowired
//	public BoardServiceImpl(BoardMapper mapper) {
//		this.mapper = mapper;
//	}
	
	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		return mapper.update(board) == 1;
	}

	@Override
	@Transactional
	public boolean remove(Long bno) {
		// 댓글 삭제
		replyMapper.deleteByBno(bno);

		// 게시물 삭제
		int cnt = mapper.delete(bno);

		return cnt == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	
}