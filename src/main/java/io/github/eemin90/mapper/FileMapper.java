package io.github.eemin90.mapper;

import io.github.eemin90.domain.FileVO;
import io.github.eemin90.domain.MemberVO;

public interface FileMapper {

	public int insert(FileVO vo);

	public void deleteByBno(Long bno);

	public void removeByUserid(MemberVO vo);
}
