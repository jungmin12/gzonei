package gzonei.adisvc.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface RewardPrcdntService {

	//샘플 정보(코드 목록) 조회
	public List<?> rewardPrdntBbsList(EgovMap map) throws SQLException , IOException;

	// 게시물 총 개수 
	public int rewardPrdntBbsListTotCnt(EgovMap searchVO) throws SQLException, IOException;
	
	// 게시물 글 작성
	public void rewardPrcdntBbsRgst(EgovMap map) throws Exception;
	
	// 게시물 조회수 증가
	public int updateBbsRdcnt(EgovMap searchVO) throws Exception;

	// 게시물 상세보기
	public EgovMap rewardPrcdntBbsDetail(EgovMap searchVO) throws Exception;
	
	// 게시물 수정
	public List<?> rewardPrcdntBbsUdt(EgovMap map) throws Exception;
	
	// 게시물 삭제
	public void rewardPrcdntBbsDelete(EgovMap map) throws Exception;
}
