package gzonei.sample.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface SampleService {
	
	//샘플 정보(코드 목록) 조회
	public List<?> selectSampleList(EgovMap map) throws SQLException , IOException;
	
	//샘플 엑셀 다운 목록 조회
	public List<?> selectSampleExcel(EgovMap map) throws SQLException , IOException;

	//레이어 불러오기
	public List<?> selectViewLayer(EgovMap searchVO) throws SQLException ,IOException;

	public void insertLayer(EgovMap searchVO) throws SQLException ,IOException;

	public void updateLayer(EgovMap searchVO) throws SQLException ,IOException;

	public void deleteLayer(EgovMap searchVO) throws SQLException ,IOException;
	
	
}
