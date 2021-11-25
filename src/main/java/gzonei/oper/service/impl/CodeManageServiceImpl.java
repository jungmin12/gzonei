package gzonei.oper.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.oper.service.CodeManageService;


@Service("CodeManageService")
public class CodeManageServiceImpl extends EgovAbstractServiceImpl implements CodeManageService{

	private static final Logger LOGGER = LoggerFactory.getLogger(CodeManageServiceImpl.class);
	
	@Resource(name="CodeManageDAO")
	private CodeManageDAO codeManageDAO;

	
	

	@Override //대분류 코드 조회
	public List<?> viewUpperCode(EgovMap map) throws SQLException, IOException {
		try {
			return codeManageDAO.viewUpperCode(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}
	
	//소분류 코드 조회
	@Override
	public List<?> viewCode(EgovMap map) throws SQLException, IOException {
		try {
			return codeManageDAO.viewCode(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}
	
	//대분류 신규 등록
	@Override 
	public void insertUpCd(Map<String, Object> commandMap) throws SQLException, IOException {
		try {
			codeManageDAO.insertUpCd(commandMap);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	//대분류 수정
	@Override 
	public void updateUpCd(Map<String, Object> commandMap) throws SQLException, IOException {
		try {
			codeManageDAO.updateUpCd(commandMap);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	//소분류 신규 등록
	@Override 
	public void insertLwCd(Map<String, Object> commandMap) throws SQLException, IOException {
		try {
			codeManageDAO.insertLwCd(commandMap);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	//소분류 수정
	@Override 
	public void updateLwCd(Map<String, Object> commandMap) throws SQLException, IOException {
		try {
			codeManageDAO.updateLwCd(commandMap);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}



	
}
