package gzonei.cmmnty.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CmmntyService {

//	게시글 리스트 호출
	List<?> selectArticleList(EgovMap searchVO)throws SQLException, IOException;
//	게시글 탭 리스트 호출
	List<?> selectTabArticleList(EgovMap searchVO)throws SQLException, IOException;
//	게시글 상세보기 호출
	EgovMap selectDetail(EgovMap searchVO)throws SQLException, IOException;
//	게시글 카운트 호출
	int selectListTotCnt(EgovMap searchVO)throws SQLException, IOException;
//	게시글 탭 카운트 호출
	int selectTabListTotCnt(EgovMap searchVO)throws SQLException, IOException;
//	게시글  생성
	int insertArticle(Map<String, Object> commandMap)throws SQLException, IOException;
//	게시글 삭제
	int deleteArticle(EgovMap searchVO)throws SQLException, IOException;
//	게시글 수정
	int updateArticle(Map<String, Object> commandMap)throws SQLException, IOException;
//	게시글 조회수 
	int updateBbsRdcnt(EgovMap searchVO)throws SQLException, IOException, Exception;
//	게시글 댓글 호출
	List<?> selectComment(EgovMap searchVO)throws SQLException, IOException;
//	게시글 생성
	void insertComment(EgovMap commentVO)throws SQLException, IOException;
//	게시글 삭제
	void deleteComment(EgovMap commentVO)throws SQLException, IOException;
//	게시글 수정
	void updateComment(EgovMap commentVO)throws SQLException, IOException;
//	게시글 답변확인
	void answerCheck(EgovMap commentVO);
// 	공지 게시글 조회
	List<?> selectNoticeList(EgovMap searchVO)throws SQLException, IOException;
// 	보도자료 링크 조회
	List<?> selectNewsList(EgovMap searchVO)throws SQLException, IOException;
	}
