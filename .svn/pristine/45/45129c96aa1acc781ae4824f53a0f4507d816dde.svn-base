package gzonei.adisvc.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface RecsroomService {
	
	// 게시판 목록
	public List<?> viewBbsList(EgovMap map) throws SQLException, IOException;
	
	// 게시판 목록 카운트
	public int viewBbsListTotCnt(EgovMap map) throws SQLException, IOException;
	
	// 게시판 상세보기
	public EgovMap viewBbsDetail(EgovMap map) throws SQLException, IOException;
	
	// 사업지구조회
	public List<?> devInfoList(EgovMap map) throws SQLException, IOException;
	
	// 게시글 조회수
	public void updateViewBbsCount(EgovMap map) throws SQLException, IOException;
	
	// 게시판 글 등록
	public void insertBbs(Map<String, Object> commandMap) throws SQLException, IOException;
	
	// 게시판 글 수정
	public void updateBbs(Map<String, Object> commandMap) throws SQLException, IOException;
	
	// 게시판 글 삭제
	public void deleteBbs(EgovMap map) throws SQLException, IOException;
	
	// 게시글의 댓글 조회
	public List<?> selectBbsCommentList(EgovMap map) throws SQLException, IOException;
	
	// 게시판 목록 카운트
	public int selectBbsCommentCnt(EgovMap map) throws SQLException, IOException;
	
	// 댓글 등록
	public void insertComment(EgovMap map) throws SQLException, IOException;

	// 댓글 삭제
	public void deleteComment(EgovMap map) throws SQLException, IOException;

	// 댓글 수정
	public void updateComment(EgovMap map) throws SQLException, IOException;
	

	
	
}
