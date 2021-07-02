package io.github.eemin90.mapper;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import io.github.eemin90.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Test
	public void testMapper() {
		assertNotNull(mapper);
	}
	
	@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(136L);
		vo.setReply("댓글 테스트");
		vo.setReplyer("user00");
		
		int cnt = mapper.insert(vo);
		assertEquals(1, cnt);
	}
	
	@Test
	public void testRead() {
		ReplyVO vo = mapper.read(1L);
		
		assertEquals("댓글 테스트", vo.getReply());
		log.info("LOG: " + vo);
	}
	
	@Test
	public void testDelete() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(136L);
		vo.setReply("댓글 테스트");
		vo.setReplyer("user00");
		
		mapper.insertSelectKey(vo);
		
		int cnt = mapper.delete(vo.getRno());
		
		assertEquals(1, cnt);
	}
	
	@Test
	public void testUpdate() {
		ReplyVO vo = mapper.read(3L);
		String update = "댓글 수정 테스트";
		vo.setReply(update);
		
		int cnt = mapper.update(vo);
		assertEquals(1, cnt);
		
		vo = mapper.read(3L);
		assertEquals(update, vo.getReply());
		
	}
	
	@Test
	public void testGetList() {
		List<ReplyVO> list = mapper.getList(136L);
		
		assertTrue(list.size() > 0);
		log.info("LOG: " + list);
	}
	
	@Test
	public void testDeleteByBno() {
		Long bno = 135L;
		
		mapper.deleteByBno(bno);
	}

}
