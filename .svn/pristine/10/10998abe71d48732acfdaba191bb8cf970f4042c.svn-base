package gzonei.gradAuth.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.gradAuth.service.GradAuthService;

@Service("gradAuthService")
public class GradAuthServiceImpl extends EgovAbstractServiceImpl implements GradAuthService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(GradAuthServiceImpl.class);

    @Resource(name="gradAuthDAO")
    private GradAuthDAO gradAuthDAO;

	@Override
	public List<?> selectGradAuthList(EgovMap vo) throws SQLException, IOException {
		try {
			return gradAuthDAO.selectGradAuthList(vo);
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
	public int selectGradAuthListTotCnt(EgovMap vo) throws SQLException, IOException {
		try {
			return gradAuthDAO.selectGradAuthListTotCnt(vo);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return -1;
	}
	
	@Override
	public void insertGradAuthInfo(EgovMap vo) throws SQLException, IOException {
		try {
			gradAuthDAO.insertGradAuthInfo(vo);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	@Override
	public void insertGradAmountInfo(EgovMap vo) throws SQLException, IOException {
		try {
			gradAuthDAO.insertGradAmountInfo(vo);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	@Override
	public void insertGradAuthDetailInfo(EgovMap vo) throws SQLException, IOException {
		try {
			gradAuthDAO.insertGradAuthDetailInfo(vo);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}

	@Override
	public EgovMap selectGradAuthInfo(EgovMap vo) throws SQLException, IOException {
		try {
			return gradAuthDAO.selectGradAuthInfo(vo);
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
	public List<?> selectGradAuthAmountInfo(EgovMap vo) throws SQLException, IOException {
		try {
			return gradAuthDAO.selectGradAuthAmountInfo(vo);
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
	public List<?> selectGradAuthDetailInfo(EgovMap vo) throws SQLException, IOException {
		try {
			return gradAuthDAO.selectGradAuthDetailInfo(vo);
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
