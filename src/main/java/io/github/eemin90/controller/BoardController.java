package io.github.eemin90.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import io.github.eemin90.domain.BoardVO;
import io.github.eemin90.domain.Criteria;
import io.github.eemin90.domain.PageDTO;
import io.github.eemin90.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class BoardController {

	private BoardService service;
	
//	@Autowired
//	public BoardController(BoardService service) {
//		this.service = service;
//	}
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("board/list method...");
		
		int total = service.getTotal(cri);
		
		// service getList() 실행 결과를
		List<BoardVO> list = service.getList(cri);
		// model에 attribute로 넣고
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		// view로 포워드
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		
		board.setFileName(file.getOriginalFilename());
		
		// service에게 등록업무 시키고
		service.register(board, file);
		
		// redirect 목적지로 정보 전달
		rttr.addFlashAttribute("result", board.getBno());
		
		// /board/list로 redirect
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// service에게 일 시킴
		BoardVO vo = service.get(bno);
		
		//결과를 모델에 넣음
		model.addAttribute("board", vo);
		
		// forward
	}
	
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(BoardVO board, Criteria cri, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		// request parameter 수집
		
		// service 일 시킴
		boolean success = service.modify(board, file);
		
		// 결과를 모델(또는 FlashMap)에 넣고
		if (success) {
			rttr.addFlashAttribute("modify", board.getBno());
		}
		
		// redirect의 QueryString 값으로 주려면 addAttribute를 이용해야 한다.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		// forward or redirect
		return "redirect:/board/list";
	}
	
	@PostMapping("/fremove")
	@PreAuthorize("principal.username == #board.writer")
	public String fremove(BoardVO board, Criteria cri, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		// request parameter 수집
		
		// service 일 시킴
		service.fremove(board, file);
		
		// 결과 담고
		rttr.addFlashAttribute("fremove", board);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		// forward or redirect
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #writer")
	public String remove(Long bno, Criteria cri, RedirectAttributes rttr, String writer) {
		// request parameter 수집
		
		// service 일 시킴
		BoardVO vo = service.get(bno);
		boolean success = service.remove(bno);
		
		// 결과 담고
		if (success) {
			rttr.addFlashAttribute("remove", vo);
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		// forward or redirect
		return "redirect:/board/list";
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register(@ModelAttribute("cri") Criteria cri) {
		// 자동으로 /WEB-INF/views/board/register.jsp 경로로 forward됨
	}
}
