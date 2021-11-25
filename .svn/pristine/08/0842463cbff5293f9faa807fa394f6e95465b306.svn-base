package gzonei.today.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.member.service.impl.MemberServiceImpl;
import gzonei.today.service.TodayAdminService;

@Service("TodayAdminService")
public class TodayAdminServiceImpl extends EgovAbstractServiceImpl implements TodayAdminService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Resource(name="TodayAdminDao")
	private TodayAdminDao todayAdminDAO;
	
	/** 희진 */
	@Override
	public List<?> selectPrtnSttusList(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectPrtnSttusList(map);
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
	public int selectPrtnSttusListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectPrtnSttusListTotCnt(map);
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
	public List<?> selectPrtnSttusListExcel(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectPrtnSttusListExcel(map);
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
	public List<?> selectDevelopGosiList(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectDevelopGosiList(map);
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
	public int selectDevelopGosiListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectDevelopGosiListTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	/** 다현*/
	
	@Override
	public List<?> selectTodayDevInfoList(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectTodayDevInfoList(map);
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
	public int selectTodayDevInfoTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectTodayDevInfoTotCnt(map);
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
	public EgovMap selectReqDevInfo(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.selectReqDevInfo(map);
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
	public int udtDevlopInfo(EgovMap map) throws SQLException, IOException {
		try {
			return todayAdminDAO.udtDevlopInfo(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
}
