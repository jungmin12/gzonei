package gzonei.cmmn.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Repository("cmmnDAO")
public class CmmnDAO extends EgovComAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnDAO.class);

	public List<?> selectCodeList(String se, String upperCodeId) throws SQLException, IOException{
		return selectList("cmmnDAO.selectCodeList"+se, upperCodeId);
	}
	
	public List<?> selectBbsList(String tabNm, String bbsId) throws SQLException, IOException{
		return selectList("cmmnDAO.selectBbsList"+tabNm, bbsId);
	}
	
	public List<?> selectBbsNewsList() throws SQLException, IOException{
		return selectList("cmmnDAO.selectBbsNewsList");
	}
	
	void insertBbscttLog(EgovMap vo) throws Exception{
		insert("cmmnDAO.insertBbscttLog",vo);
	}

	public String selectCodeName(String codeId) throws SQLException, IOException{
		return selectOne("cmmnDAO.selectCodeName",codeId);
	}

	public List<?> selectLayer(EgovMap searchVO) throws SQLException, IOException{
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectLayer", searchVO);
	}

	public List<?> selectDevTop()  throws SQLException, IOException{
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectDevTop");
	}
	
	public EgovMap selectDevCt()  throws SQLException, IOException{
		// TODO Auto-generated method stub
		return selectOne("cmmnDAO.selectDevCt");
	}

	public List<?> selectBannerList(String code)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectBannerList",code);
	}
	
	public List<?> selectAuth(EgovMap vo)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectAuth",vo);
	}
	
	public List<?> selectOneAuth(EgovMap vo)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectOneAuth",vo);
	}

	public List<?> selectFreeSample()throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectFreeSample");
	}

	public List<?> selectUpdateDevNmList()throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectUpdateDevNmList");
	}

	public List<?> selectDstrcCntByCodeLvl() throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectDstrcCntByCodeLvl");
	}

	public List<?> selectCodeListCMMNCodeId(EgovMap map) throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectCodeListCMMNCodeId",map);
	}

	public List<?> selectCodeListAll(String string) throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("cmmnDAO.selectCodeListAll",string);
	}



}
