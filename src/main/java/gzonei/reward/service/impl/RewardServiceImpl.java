package gzonei.reward.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.invt.service.impl.InvtServiceImpl;
import gzonei.reward.service.RewardService;

@Service("RewardService")
public class RewardServiceImpl extends EgovAbstractServiceImpl implements RewardService{
	private static final Logger LOGGER = LoggerFactory.getLogger(RewardServiceImpl.class);
	
	@Resource(name="RewardDAO")
	private RewardDAO rewardDAO;

	@Override
	public List<?> selectRewardAdmList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		try {
			return rewardDAO.selectRewardAdmList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}

	@Override
	public int selectRewardAdmListCnt(EgovMap map) throws SQLException, IOException {
		try {
			return rewardDAO.selectRewardAdmListCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}

	@Override
	public int insertRewardDetail(EgovMap map) throws SQLException, IOException {
		try {
			return rewardDAO.insertRewardDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}

	@Override
	public EgovMap selectRewardDetail(EgovMap map) throws SQLException, IOException {
		try {
			return rewardDAO.selectRewardDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}

	@Override
	public int updateRewardDetail(EgovMap map) throws SQLException, IOException {
		try {
			return rewardDAO.updateRewardDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}

	@Override
	public int deleteRewardDetail(EgovMap map) throws SQLException, IOException {
		try {
			return rewardDAO.deleteRewardDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}

	@Override
	public List<?> selectInfoReward(EgovMap map) throws SQLException, IOException {
		try {
			return rewardDAO.selectInfoReward(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}

}
