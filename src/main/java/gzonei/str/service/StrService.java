package gzonei.str.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface StrService {
		//샘플 정보(코드 목록) 조회
		public List<?> strBbsList(EgovMap map) throws SQLException , IOException;
		
		//샘플 정보(코드 목록) 조회
		public List<?> strSuccesBbsList(EgovMap map) throws SQLException , IOException;
		
		//샘플 정보(코드 목록) 조회
		public List<?> strFailrBbsList(EgovMap map) throws SQLException , IOException;
		
		// 게시물 총 개수 
		public int selectStrListTotCnt(EgovMap searchVO)throws SQLException, IOException;
				
		// 보상 경ㆍ공매 성공, 실패 조회 
		public List<?> gzstrSelectCase(EgovMap map) throws Exception;
		
		// 게시물 조회수 증가
		public int updateBbsRdcnt(EgovMap searchVO) throws Exception;
		
		// 실패사례 상세보기
		public EgovMap strBbsDetail(EgovMap map) throws Exception;

		// 게시물 글 작성
		public void strBbsRgst(EgovMap map) throws Exception;
		
		// 게시물 수정
		public List<?> strBbsUdt(EgovMap map) throws Exception;
		
		// 게시물 삭제
		public void strBbsDelete(EgovMap map) throws Exception;

}
