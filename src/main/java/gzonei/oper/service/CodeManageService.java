package gzonei.oper.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CodeManageService {
	
	// 대분류 코드
	public List<?> viewUpperCode(EgovMap map) throws SQLException, IOException;
	
	// 소분류 코드
	public List<?> viewCode(EgovMap map) throws SQLException, IOException;
	
	// 대분류 신규 등록
	public void insertUpCd(Map<String, Object> commandMap) throws SQLException, IOException;

	// 대분류 코드 수정
	public void updateUpCd(Map<String, Object> commandMap) throws SQLException, IOException;
	
	// 소분류 신규 등록
	public void insertLwCd(Map<String, Object> commandMap) throws SQLException, IOException;
	
	// 소분류 코드 수정
	public void updateLwCd(Map<String, Object> commandMap) throws SQLException, IOException;
}
