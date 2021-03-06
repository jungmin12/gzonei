package gzonei.oper.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("OperDAO")
public class OperDAO extends EgovComAbstractDAO {

	public List<?> selectSampleList(EgovMap map) throws Exception {
        return selectList("OperDAO.selectSampleList", map);
    }
	// 게시판 글 목록
	public List<?> viewBbsList(EgovMap map) throws Exception{
		return selectList("OperDAO.viewBbsList", map);
	}
	
	// 게시판 글 목록 카운트
	public int viewBbsListTotCnt(EgovMap map) throws Exception{
		return selectOne("OperDAO.viewBbsListTotCnt", map);
	}

	// 게시판 상세보기
	public EgovMap viewBbsDetail(EgovMap map) throws Exception{
		return selectOne("OperDAO.viewBbsDetail", map);
	}
	
	// 게시글 조회수+1
	public void updateViewBbsCount(EgovMap map) throws Exception{
		update("OperDAO.updateViewBbsCount", map);
	}
	
	// 게시글 등록하기
	public void insertBbs(Map<String, Object> commandMap) throws Exception{
		insert("OperDAO.insertBbs", commandMap);
	}
	
	// 게시글 수정하기
	public void updateBbs(Map<String, Object> commandMap) throws Exception{
		update("OperDAO.updateBbs", commandMap);
	}
	
	// 게시글 삭제하기
	public void deleteBbs(Map<String, Object> commandMap) throws Exception{
		update("OperDAO.deleteBbs", commandMap);
	}
	
	// 게시판 글의 댓글 목록
	public List<?> selectBbsCommentList(EgovMap map) throws Exception{
		return selectList("OperDAO.selectBbsCommentList", map);
	}
	
	// 게시판 댓글 등록하기
	public void insertComment(EgovMap map) throws Exception{
		insert("OperDAO.insertComment", map);
	}
	
	// 게시판 댓글 삭제하기
	public void deleteComment(EgovMap map) throws Exception{
		update("OperDAO.deleteComment", map);
	}
	
	// 게시판 댓글 삭제하기
	public void updateComment(EgovMap map) throws Exception{
		update("OperDAO.updateComment", map);
	}

}
