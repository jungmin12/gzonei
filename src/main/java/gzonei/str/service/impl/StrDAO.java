package gzonei.str.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("StrDAO")
public class StrDAO extends EgovComAbstractDAO {

	// 게시물 총 개수
	public int selectStrListTotCnt(EgovMap map) {
		return selectOne("StrDAO.selectStrListTotCnt", map);
	}
	
	// 게시물 조회
	public List<?> strBbsList(EgovMap map) throws Exception {
        return selectList("StrDAO.strBbsList", map);
    }
	
	public List<?> strSuccesBbsList(EgovMap map) throws Exception {
		return selectList("StrDAO.strBbsList", map);
	}
	
	public List<?> strFailrBbsList(EgovMap map) throws Exception {
		return selectList("StrDAO.strBbsList", map);
	}
	
	// 보상 경ㆍ공매 성공, 실패 조회 
	public List<?> gzstrSelectCase(EgovMap map) throws Exception {
		return selectList("StrDAO.gzstrSelectCase", map);
	}
	
	// 조회수 1씩 증가
	public int updateBbsRdcnt(EgovMap map) throws Exception {
		return update("StrDAO.updateBbsRdcnt", map);
	}
	
	// 실패사례 상세보기
	public EgovMap strBbsDetail(EgovMap map) throws Exception {
		return selectOne("StrDAO.strBbsDetail", map);
	}
	
	// 게시판 글 작성
	public List<?> strBbsRgst(EgovMap map) throws Exception {
		return selectList("StrDAO.strBbsRgst", map);
	}
	
	// 게시물 수정
	public List<?> strBbsUdt(EgovMap map) throws Exception {
		return selectList("StrDAO.strBbsUdt", map);
	}
	
	// 게시물 삭제
	public void strBbsDelete(EgovMap map) throws Exception {
		update("StrDAO.strBbsDelete", map);
	}
	
}
