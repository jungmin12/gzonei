package gzonei.reward.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface RewardService {

	List<?> selectRewardAdmList(EgovMap map) throws SQLException, IOException;

	int selectRewardAdmListCnt(EgovMap map) throws SQLException, IOException;

	int insertRewardDetail(EgovMap map) throws SQLException, IOException;

	EgovMap selectRewardDetail(EgovMap map) throws SQLException, IOException;

	int updateRewardDetail(EgovMap map) throws SQLException, IOException;

	int deleteRewardDetail(EgovMap map) throws SQLException, IOException;

	List<?> selectInfoReward(EgovMap map) throws SQLException, IOException;


}
