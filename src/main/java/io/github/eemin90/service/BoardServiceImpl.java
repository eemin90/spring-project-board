package io.github.eemin90.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import io.github.eemin90.domain.BoardVO;
import io.github.eemin90.domain.Criteria;
import io.github.eemin90.domain.FileVO;
import io.github.eemin90.mapper.BoardMapper;
import io.github.eemin90.mapper.FileMapper;
import io.github.eemin90.mapper.ReplyMapper;
import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

//@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	public BoardServiceImpl() {
		this.bucketName = "choongang-eemin90";
		this.profileName = "spring1";
		/*  
		 * create
		 *  /home/tomcat/.aws/credentials
		 */
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	@Setter(onMethod_ = @Autowired)
	private FileMapper fileMapper;
	
//	@Autowired
//	public BoardServiceImpl(BoardMapper mapper) {
//		this.mapper = mapper;
//	}
	
	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);
	}

	@Override
	public void register(BoardVO board, MultipartFile file) {
		register(board);
		
		if (file != null && file.getSize() > 0) {
			FileVO vo = new FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(board, file);
		}
	}

	private void upload(BoardVO board, MultipartFile file) {
		try (InputStream is = file.getInputStream()) {
			
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(board.getBno() + "/" + file.getOriginalFilename()) // aws??? ????????? ?????? ????????? ?????? ??????
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
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
	public boolean modify(BoardVO board, MultipartFile file) {
		if (file != null && file.getSize() > 0) {
			// aws??? ?????? ??? ????????????
			BoardVO oldBoard = mapper.read(board.getBno());
			removeFile(oldBoard);
			upload(board, file);
			
			// DB??? ?????? ??? insert
			fileMapper.deleteByBno(board.getBno());
			FileVO vo = new FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			fileMapper.insert(vo);
		}
		return modify(board);
	}

	@Override
	@Transactional
	public boolean remove(Long bno) {
		// ?????? ??????
		replyMapper.deleteByBno(bno);
		
		// ?????? ??????(AWS)
		BoardVO vo = mapper.read(bno);
		removeFile(vo);
		
		// ?????? ??????(DB)
		fileMapper.deleteByBno(bno);
		
		// ????????? ??????
		int cnt = mapper.delete(bno);

		return cnt == 1;
	}
	
	@Override
	@Transactional
	public void fremove(BoardVO board, MultipartFile file) {
		// ?????? ??????(AWS)
		BoardVO vo = mapper.read(board.getBno());
		removeFile(vo);
		
		// ?????? ??????(DB)
		fileMapper.deleteByBno(board.getBno());
	}

	private void removeFile(BoardVO vo) {
		String key = vo.getBno() + "/" + vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
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
