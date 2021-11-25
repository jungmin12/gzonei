package gzonei.str.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.sample.service.impl.SampleServiceImpl;
import gzonei.str.service.StrService;

@Service("StrService")
public class StrServiceImpl implements StrService {
private static final Logger LOGGER = LoggerFactory.getLogger(SampleServiceImpl.class);
	
	@Resource(name="StrDAO")
	private StrDAO strDAO;
	
	@Override
	public List<?> strBbsList(EgovMap map) throws SQLException, IOException {
		try {
			return strDAO.strBbsList(map);
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
	public List<?> strSuccesBbsList(EgovMap map) throws SQLException, IOException {
		try {
			return strDAO.strSuccesBbsList(map);
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
	public List<?> strFailrBbsList(EgovMap map) throws SQLException, IOException {
		try {
			return strDAO.strFailrBbsList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return null;
	}
	
	// 게시물 총 개수
	@Override
	public int selectStrListTotCnt(EgovMap map) throws SQLException, IOException {
		return strDAO.selectStrListTotCnt(map);
	}
	
	// 보상 경ㆍ공매 성공, 실패 조회 
	@Override
	public List<?> gzstrSelectCase(EgovMap map) throws Exception {
		return strDAO.gzstrSelectCase(map);
	}
	
	// 조회수 1씩 증가 
	@Override
	public int updateBbsRdcnt(EgovMap map) throws Exception {
		return strDAO.updateBbsRdcnt(map);
	}
	
	// 실패사례 상세보기
	@Override
	public EgovMap strBbsDetail(EgovMap map) throws Exception {
		return strDAO.strBbsDetail(map);
	}
	
	// 게시판 글 작성
	@Override
	public void strBbsRgst(EgovMap map) throws Exception {
		strDAO.strBbsRgst(map);
	}
	
	// 게시물 수정
	@Override
	public List<?> strBbsUdt(EgovMap map) throws Exception {
		return strDAO.strBbsUdt(map);
	}
	// 게시물 삭제
	@Override
	public void strBbsDelete(EgovMap map) throws Exception {
		strDAO.strBbsDelete(map);
	}
	
}
