package gzonei.reward.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("RewardDAO")
public class RewardDAO extends EgovComAbstractDAO {

	public List<?> selectRewardAdmList(EgovMap map) throws SQLException, IOException {
        return selectList("RewardDAO.selectRewardAdmList", map);
	}

	public int selectRewardAdmListCnt(EgovMap map) throws SQLException, IOException {
        return selectOne("RewardDAO.selectRewardAdmListCnt", map);
	}

	public int insertRewardDetail(EgovMap map) throws SQLException, IOException {
		
		 return insert("RewardDAO.insertRewardDetail", map);
	}

	public EgovMap selectRewardDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return  selectOne("RewardDAO.selectRewardDetail", map);
	}

	public int updateRewardDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("RewardDAO.updateRewardDetail", map);
	}

	public int deleteRewardDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return delete("RewardDAO.deleteRewardDetail", map);
	}

	public List<?> selectInfoReward(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("RewardDAO.selectInfoReward", map);
	}


}
