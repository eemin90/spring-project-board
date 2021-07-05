package io.github.eemin90.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import io.github.eemin90.domain.BoardVO;
import io.github.eemin90.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
//	public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);

	public int getTotal(Criteria cri);

	public void register(BoardVO board, MultipartFile file);

	public boolean modify(BoardVO board, MultipartFile file);

	public void fremove(BoardVO board, MultipartFile file);
	
}
