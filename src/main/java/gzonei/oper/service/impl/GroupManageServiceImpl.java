package gzonei.oper.service.impl;

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
import gzonei.oper.service.GroupManageService;

@Service("GroupManageService")
public class GroupManageServiceImpl  extends EgovAbstractServiceImpl implements GroupManageService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Resource(name="GroupManageDAO")
	private GroupManageDAO groupManageDAO;
	
	@Override
	public List<?> selectGroupList() throws SQLException, IOException {
		try {
			return groupManageDAO.selectGroupList();
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
	public EgovMap selectGroupInfoDt(EgovMap map) throws SQLException, IOException {
		try {
			return groupManageDAO.selectGroupInfoDt(map);
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
	public  List<?> selectGroupMember(EgovMap map) throws SQLException, IOException {
		try {
				return groupManageDAO.selectGroupMember(map);		
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
	public  List<?> selectMemberSearch(EgovMap map) throws SQLException, IOException {
		try {
				return groupManageDAO.selectMemberSearch(map);		
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
	public int updateGroupMember(EgovMap map) throws SQLException, IOException {
		try {
			return groupManageDAO.updateGroupMember(map);
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
	public int insertNewGroup(EgovMap map) throws SQLException, IOException {
		try {
			return groupManageDAO.insertNewGroup(map);
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
	public int groupDelete(EgovMap map) throws SQLException, IOException {
		try {
			return groupManageDAO.groupDelete(map);
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
