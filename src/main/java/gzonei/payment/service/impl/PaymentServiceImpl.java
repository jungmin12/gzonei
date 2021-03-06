package gzonei.payment.service.impl;

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
import gzonei.member.service.impl.MemberServiceImpl;
import gzonei.payment.service.PaymentService;

@Service("PaymentService")
public class PaymentServiceImpl extends EgovAbstractServiceImpl implements PaymentService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Resource(name="PaymentDao")
	private PaymentDao paymentDAO;
	
	/** 희진 */
	@Override
	public List<?> selectExcclcList(EgovMap map) throws SQLException, IOException {
		try {
			return paymentDAO.selectExcclcList(map);
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
	public int selectExcclcListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return paymentDAO.selectExcclcListTotCnt(map);
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
	public int insertExcclcInfo(Map<String, Object> map) throws SQLException, IOException {
		try {
			return paymentDAO.insertExcclcInfo(map);
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
	public EgovMap selectExcclcDetail(EgovMap map) throws SQLException, IOException {
		try {
			return paymentDAO.selectExcclcDetail(map);
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
	public int updateExcclcInfo(Map<String, Object> map) throws SQLException, IOException {
		try {
			return paymentDAO.updateExcclcInfo(map);
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
	public List<?> selectNbkkCnfirmList(EgovMap map) throws SQLException, IOException {
		try {
			return paymentDAO.selectNbkkCnfirmList(map);
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
	public int selectNbkkCnfirmListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return paymentDAO.selectNbkkCnfirmListTotCnt(map);
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
