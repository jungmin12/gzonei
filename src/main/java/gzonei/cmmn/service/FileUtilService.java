package gzonei.cmmn.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface FileUtilService {
	
	// 첨부파일파일 속성 넣기
	public List<?> insertFileAtrb(EgovMap map) throws Exception;
	
	// 첨부파일파일 상세정보 넣기
	public List<?> insertFileDetail(EgovMap map) throws Exception;
	
	// 수정할 수 있는 파일 리스트 조회
	public List<?> selectAtchFileArray(String atchFileId);
	
	// 첨부파일 아이디 조회
	public String selectAtchFileId(EgovMap map);

	// 첨부파일 상세정보 조회
	public List<?> selectAtchFileDetail(String atchFileId);
	
	// 첨부파일명 조회
	public EgovMap selectAtchFileNm(EgovMap map);
	
	// 첨부파일 삭제
	public void deleteAtchFile(EgovMap map) throws Exception;
	
	// 첨부파일 속성 삭제
	public void deleteAtchFileAtrb(EgovMap map);
	
}
