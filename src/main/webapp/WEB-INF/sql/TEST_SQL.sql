USE spr1;


-- 게시글 페이지
SELECT * FROM tbl_board
ORDER BY bno DESC
LIMIT 5; -- 상위 5 개

SELECT * FROM tbl_board
ORDER BY bno DESC
LIMIT 0, 5; -- 0번부터 상위 5 개 (1page)

SELECT * FROM tbl_board
ORDER BY bno DESC
LIMIT 5, 5; -- 5번부터 상위 5 개 (2page)

SELECT * FROM tbl_board
ORDER BY bno DESC
LIMIT 10, 5; -- 10번부터 상위 5 개 (3page)

SELECT * FROM tbl_board
ORDER BY bno DESC
LIMIT 10 * (n-1) , 5; -- (n page)


-- 제목 검색
SELECT * FROM tbl_board
WHERE title LIKE '%자바%'
ORDER BY bno DESC
LIMIT 0, 10;


-- 제목 본문 검색
SELECT * FROM tbl_board
WHERE 
title LIKE '%자바%'
OR content LIKE '%자바%'
ORDER BY bno DESC;


-- 제목 본문 작성자 검색
SELECT * FROM tbl_board
WHERE 
title LIKE '%자바%'
OR content LIKE '%자바%'
OR writer LIKE '%자바%'
ORDER BY bno DESC
LIMIT 0, 10;


-- 각 게시물 댓글 개수
SELECT b.bno,
b.title,
b.content,
b.writer,
b.regdate,
b.updatedate,
count(r.rno)
FROM tbl_board b LEFT JOIN tbl_reply r ON b.bno = r.bno
GROUP BY b.bno
ORDER BY b.bno DESC
LIMIT 0, 10;