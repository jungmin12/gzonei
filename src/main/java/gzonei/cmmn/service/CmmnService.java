package gzonei.cmmn.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.IIOException;
import javax.servlet.http.HttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface CmmnService {
	List<?> selectCodeList(String se, String upperCodeId) throws SQLException, IOException;
	
	List<?> selectBbsList(String tabNm, String bbsId) throws SQLException, IOException;
	
	List<?> selectBbsNewsList() throws SQLException, IOException;
	
	void insertBbscttLog(EgovMap vo) throws Exception;
	
	String getClientIpAddr(HttpServletRequest request) throws Exception;

	String selectCodeName(String codeId) throws SQLException, IOException;

	List<?> selectLayer(EgovMap searchVO) throws SQLException, IOException;

	List<?> selectDevTop() throws SQLException, IOException;
	
	EgovMap selectDevCt() throws SQLException, IOException;

	List<?> selectBannerList(String string)throws SQLException,IOException;
	
	List<?> selectAuth(EgovMap vo) throws SQLException, IOException;

	List<?> selectOneAuth(EgovMap vo) throws SQLException, IOException;
	
	List<?> selectFreeSample() throws SQLException, IOException;

	List<?> selectUpdateDevNmList()throws SQLException, IOException;

	List<?> selectDstrcCodeList()throws SQLException, IOException;

	List<?> selectCodeListCMMNCodeId(EgovMap map)throws SQLException, IOException;

	List<?> selectCodeListAll(String string)throws SQLException, IOException;
}
