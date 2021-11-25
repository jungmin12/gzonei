package gzonei.gradAuth.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface GradAuthService {
	
	List<?> selectGradAuthList(EgovMap vo) throws SQLException, IOException;
	
	int selectGradAuthListTotCnt(EgovMap vo) throws SQLException, IOException;
	
	void insertGradAuthInfo(EgovMap vo) throws SQLException, IOException;
	
	void insertGradAmountInfo(EgovMap vo) throws SQLException, IOException;
	
	void insertGradAuthDetailInfo(EgovMap vo) throws SQLException, IOException;
	
	EgovMap selectGradAuthInfo(EgovMap vo) throws SQLException, IOException;
	
	List<?> selectGradAuthAmountInfo(EgovMap vo) throws SQLException, IOException;
	
	List<?> selectGradAuthDetailInfo(EgovMap vo) throws SQLException, IOException;
	
}
