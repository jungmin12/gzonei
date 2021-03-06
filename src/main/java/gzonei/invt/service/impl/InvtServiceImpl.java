package gzonei.invt.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.invt.service.InvtService;

@Service("InvtService")
public class InvtServiceImpl extends EgovAbstractServiceImpl implements InvtService{

	private static final Logger LOGGER = LoggerFactory.getLogger(InvtServiceImpl.class);
	
	@Resource(name="InvtDAO")
	private InvtDAO invtDAO;

	@Override
	public List<?> selectInvtList(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectInvtList(map);
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
	public int selectInvtListCnt(EgovMap map)  {
		try {
			return invtDAO.selectInvtListCnt(map);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}

	@Override
	public EgovMap selectInvtDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectInvtDetail(map);
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
	public List<?> selectProList(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectProList(map);
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
	public List<?> selectUseList(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectUseList(map);
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
	public EgovMap selectUseDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectUseDetail(map);
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
	public EgovMap selectProDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectProDetail(map);
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
	public int insertInvDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.insertInvDetail(map);
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
	public int deleteInvtInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.deleteInvtInfoDetail(map);
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
	public int updateInvtInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.updateInvtInfoDetail(map);
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
	public int deleteUseInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.deleteUseInfoDetail(map);
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
	public int updateUseInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.updateUseInfoDetail(map);
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
	public int insertUseInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.insertUseInfoDetail(map);
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
	public int deleteProInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.deleteProInfoDetail(map);
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
	public int updateProInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.updateProInfoDetail(map);
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
	public int insertProInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.insertProInfoDetail(map);
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
	public List<?> selectInvtAdmList(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectInvtAdmList(map);
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
	public int selectInvtAdmListCnt(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectInvtAdmListCnt(map);
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
	public EgovMap insertInvSn() throws SQLException, IOException {
		try {
			return invtDAO.insertInvSn();
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}

	@Override
	public int selectInvtOverlap(EgovMap map) throws SQLException, IOException {
		try {
			return invtDAO.selectInvtOverlap(map);
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
