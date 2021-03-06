package gzonei.adisvc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("RewardPrcdntDAO")
public class RewardPrcdntDAO extends EgovComAbstractDAO {
	
	// 게시물 총 개수
	public int rewardPrdntBbsListTotCnt(EgovMap map) {
		return selectOne("RewardPrcdntDAO.rewardPrdntBbsListTotCnt", map);
	}
	
	// 게시물 조회
	public List<?> rewardPrdntBbsList(EgovMap map) throws Exception {
        return selectList("RewardPrcdntDAO.rewardPrdntBbsList", map);
    }
	
	// 게시판 글 작성
	public List<?> rewardPrcdntBbsRgst(EgovMap map) throws Exception {
		return selectList("RewardPrcdntDAO.rewardPrcdntBbsRgst", map);
	}
	
	// 조회수 1씩 증가
	public int updateBbsRdcnt(EgovMap map) throws Exception {
		return update("RewardPrcdntDAO.updateBbsRdcnt", map);
	}
	
	// 실패사례 상세보기
	public EgovMap rewardPrcdntBbsDetail(EgovMap map) throws Exception {
		return selectOne("RewardPrcdntDAO.rewardPrcdntBbsDetail", map);
	}
	
	// 게시물 수정
	public List<?> rewardPrcdntBbsUdt(EgovMap map) throws Exception {
		return selectList("RewardPrcdntDAO.rewardPrcdntBbsUdt", map);
	}
	
	// 게시물 삭제
	public void rewardPrcdntBbsDelete(EgovMap map) throws Exception {
		update("RewardPrcdntDAO.rewardPrcdntBbsDelete", map);
	}
}
