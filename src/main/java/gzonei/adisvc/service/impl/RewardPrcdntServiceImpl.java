package gzonei.adisvc.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.adisvc.service.RewardPrcdntService;
import gzonei.sample.service.impl.SampleServiceImpl;

@Service("RewardPrcdntService")
public class RewardPrcdntServiceImpl implements RewardPrcdntService {
private static final Logger LOGGER = LoggerFactory.getLogger(SampleServiceImpl.class);

	@Resource(name="RewardPrcdntDAO")
	private RewardPrcdntDAO rewardPrcdntDAO;
	
	// 보상판례 게시물 조회
	@Override
	public List<?> rewardPrdntBbsList(EgovMap map) throws SQLException, IOException {
		try {
			return rewardPrcdntDAO.rewardPrdntBbsList(map);
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
	public int rewardPrdntBbsListTotCnt(EgovMap map) throws SQLException, IOException {
		return rewardPrcdntDAO.rewardPrdntBbsListTotCnt(map);
	}
	
	// 게시판 글 작성
	@Override
	public void rewardPrcdntBbsRgst(EgovMap map) throws Exception {
		rewardPrcdntDAO.rewardPrcdntBbsRgst(map);
	}
	// 조회수 1씩 증가 
	@Override
	public int updateBbsRdcnt(EgovMap map) throws Exception {
		return rewardPrcdntDAO.updateBbsRdcnt(map);
	}
	
	// 실패사례 상세보기
	@Override
	public EgovMap rewardPrcdntBbsDetail(EgovMap map) throws Exception {
		return rewardPrcdntDAO.rewardPrcdntBbsDetail(map);
	}
	
	// 게시물 수정
	@Override
	public List<?> rewardPrcdntBbsUdt(EgovMap map) throws Exception {
		return rewardPrcdntDAO.rewardPrcdntBbsUdt(map);
	}
	
	// 게시물 삭제
	@Override
	public void rewardPrcdntBbsDelete(EgovMap map) throws Exception {
		rewardPrcdntDAO.rewardPrcdntBbsDelete(map);
	}
}
