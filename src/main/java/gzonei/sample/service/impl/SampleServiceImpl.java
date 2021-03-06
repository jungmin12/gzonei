package gzonei.sample.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.sample.service.SampleService;

@Service("SampleService")
public class SampleServiceImpl extends EgovAbstractServiceImpl implements SampleService{

	private static final Logger LOGGER = LoggerFactory.getLogger(SampleServiceImpl.class);
	
	@Resource(name="SampleDAO")
	private SampleDAO sampleDAO;

	@Override
	public List<?> selectSampleList(EgovMap map) throws SQLException, IOException {
		try {
			return sampleDAO.selectSampleList(map);
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
	public List<?> selectSampleExcel(EgovMap map) throws SQLException, IOException {
		try {
			return sampleDAO.selectSampleExcel(map);
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
	public List<?> selectViewLayer(EgovMap searchVO) throws SQLException, IOException {
		try {
			return sampleDAO.selectViewLayer(searchVO);
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
	public void insertLayer(EgovMap searchVO) throws SQLException, IOException {
		
		try {
			sampleDAO.insertLayer(searchVO);
		}  catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
	}

	@Override
	public void updateLayer(EgovMap searchVO) throws SQLException, IOException {
		
		try {
			sampleDAO.updateLayer(searchVO);
		}  catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}

	@Override
	public void deleteLayer(EgovMap searchVO) throws SQLException, IOException {

		try {
			sampleDAO.deleteLayer(searchVO);
		}  catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
	}
	

	
}
