package gzonei.adisvc.service.impl;

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
import gzonei.adisvc.service.RecsroomService;

@Service("RecsroomService")
public class RecsroomServiceImpl extends EgovAbstractServiceImpl implements RecsroomService{

	private static final Logger LOGGER = LoggerFactory.getLogger(RecsroomServiceImpl.class);
	
	@Resource(name="RecsroomDAO")
	private RecsroomDAO recsroomDAO;

	

	@Override //게시판 목록
	public List<?> viewBbsList(EgovMap map) throws SQLException, IOException {
		try {
			return recsroomDAO.viewBbsList(map);
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
			return recsroomDAO.viewBbsListTotCnt(map);
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
			return recsroomDAO.viewBbsDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override //사업지구
	public List<?> devInfoList(EgovMap map) throws SQLException, IOException {
		try {
			return recsroomDAO.devInfoList(map);
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
			recsroomDAO.updateViewBbsCount(map);
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
			recsroomDAO.insertBbs(commandMap);
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
			recsroomDAO.updateBbs(commandMap);
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
			recsroomDAO.deleteBbs(map);
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
			return recsroomDAO.selectBbsCommentList(map);
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
	public int selectBbsCommentCnt(EgovMap map) throws SQLException, IOException {
		try {
			return recsroomDAO.selectBbsCommentCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	// 댓글 등록
	@Override
	public void insertComment(EgovMap map) throws SQLException, IOException {
		try {
			recsroomDAO.insertComment(map);
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
			recsroomDAO.deleteComment(map);
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
			recsroomDAO.updateComment(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}	
	



	
}
