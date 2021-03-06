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
import gzonei.oper.service.OperService;

@Service("OperService")
public class OperServiceImpl extends EgovAbstractServiceImpl implements OperService{

	private static final Logger LOGGER = LoggerFactory.getLogger(OperServiceImpl.class);
	
	@Resource(name="OperDAO")
	private OperDAO operDAO;

	
	
	@Override
	public List<?> selectSampleList(EgovMap map) throws SQLException, IOException {
		try {
			return operDAO.selectSampleList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}

	@Override //게시판 목록
	public List<?> viewBbsList(EgovMap map) throws SQLException, IOException {
		try {
			return operDAO.viewBbsList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override //게시판 목록 카운트
	public int viewBbsListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return operDAO.viewBbsListTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override //상세보기
	public EgovMap viewBbsDetail(EgovMap map) throws SQLException, IOException {
		try {
			return operDAO.viewBbsDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	
	@Override //조회수 +1
	public void updateViewBbsCount(EgovMap map) throws SQLException, IOException {
		try {
			operDAO.updateViewBbsCount(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	//게시글 등록하기
	@Override 
	public void insertBbs(Map<String, Object> commandMap) throws SQLException, IOException {
		try {
			operDAO.insertBbs(commandMap);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}

	// 게시글 수정하기
	@Override
	public void updateBbs(Map<String, Object> commandMap) throws SQLException, IOException {
		try {
			operDAO.updateBbs(commandMap);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 	
	}

	// 게시글 삭제하기
	@Override
	public void deleteBbs(EgovMap map) throws SQLException, IOException {
		try {
			operDAO.deleteBbs(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	// 댓글 조회
	@Override
	public List<?> selectBbsCommentList(EgovMap map) throws SQLException, IOException {
		try {
			return operDAO.selectBbsCommentList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	// 댓글 등록
	@Override
	public void insertComment(EgovMap map) throws SQLException, IOException {
		try {
			operDAO.insertComment(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	// 댓글 삭제
	@Override
	public void deleteComment(EgovMap map) throws SQLException, IOException {
		try {
			operDAO.deleteComment(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	// 댓글 수정
	@Override
	public void updateComment(EgovMap map) throws SQLException, IOException {
		try {
			operDAO.updateComment(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}	
	



	
}
