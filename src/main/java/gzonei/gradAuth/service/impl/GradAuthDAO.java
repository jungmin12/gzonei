package gzonei.gradAuth.service.impl;

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


@Repository("gradAuthDAO")
public class GradAuthDAO extends EgovComAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(GradAuthDAO.class);

	public List<?> selectGradAuthList(EgovMap vo) throws SQLException, IOException{
		return selectList("gradAuthDAO.selectGradAuthList", vo);
	}

	public int selectGradAuthListTotCnt(EgovMap vo) throws SQLException, IOException{
		return selectOne("gradAuthDAO.selectGradAuthListTotCnt", vo);
	}
	
	public void insertGradAuthInfo(EgovMap vo) throws SQLException, IOException{
		insert("gradAuthDAO.insertGradAuthInfo", vo);
	}
	
	public void insertGradAmountInfo(EgovMap vo) throws SQLException, IOException{
		insert("gradAuthDAO.insertGradAmountInfo", vo);
	}
	
	public void insertGradAuthDetailInfo(EgovMap vo) throws SQLException, IOException{
		insert("gradAuthDAO.insertGradAuthDetailInfo", vo);
	}
	
	public EgovMap selectGradAuthInfo(EgovMap vo) throws SQLException, IOException{
		return selectOne("gradAuthDAO.selectGradAuthInfo", vo);
	}
	
	public List<?> selectGradAuthAmountInfo(EgovMap vo) throws SQLException, IOException{
		return selectList("gradAuthDAO.selectGradAuthAmountInfo", vo);
	}
	
	public List<?> selectGradAuthDetailInfo(EgovMap vo) throws SQLException, IOException{
		return selectList("gradAuthDAO.selectGradAuthDetailInfo", vo);
	}


}
