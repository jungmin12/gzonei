package gzonei.adisvc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("RecsroomDAO")
public class RecsroomDAO extends EgovComAbstractDAO {

	// 게시판 글 목록
	public List<?> viewBbsList(EgovMap map) throws Exception{
		return selectList("RecsroomDAO.viewBbsList", map);
	}
	
	// 게시판 글 목록 카운트
	public int viewBbsListTotCnt(EgovMap map) throws Exception{
		return selectOne("RecsroomDAO.viewBbsListTotCnt", map);
	}

	// 게시판 상세보기
	public EgovMap viewBbsDetail(EgovMap map) throws Exception{
		return selectOne("RecsroomDAO.viewBbsDetail", map);
	}
	
	// 사업지구
	public List<?> devInfoList(EgovMap map) throws Exception{
		return selectList("RecsroomDAO.devInfoList", map);
	}
	
	// 게시글 조회수+1
	public void updateViewBbsCount(EgovMap map) throws Exception{
		update("RecsroomDAO.updateViewBbsCount", map);
	}
	
	// 게시글 등록하기
	public void insertBbs(Map<String, Object> commandMap) throws Exception{
		insert("RecsroomDAO.insertBbs", commandMap);
	}
	
	// 게시글 수정하기
	public void updateBbs(Map<String, Object> commandMap) throws Exception{
		update("RecsroomDAO.updateBbs", commandMap);
	}
	
	// 게시글 삭제하기
	public void deleteBbs(Map<String, Object> commandMap) throws Exception{
		update("RecsroomDAO.deleteBbs", commandMap);
	}
	
	// 게시판 글의 댓글 목록
	public List<?> selectBbsCommentList(EgovMap map) throws Exception{
		return selectList("RecsroomDAO.selectBbsCommentList", map);
	}
	
	// 게시판 댓글 카운트
	public int selectBbsCommentCnt(EgovMap map) throws Exception{
		return selectOne("RecsroomDAO.selectBbsCommentCnt", map);
	}
	
	// 게시판 댓글 등록하기
	public void insertComment(EgovMap map) throws Exception{
		insert("RecsroomDAO.insertComment", map);
	}
	
	// 게시판 댓글 삭제하기
	public void deleteComment(EgovMap map) throws Exception{
		update("RecsroomDAO.deleteComment", map);
	}
	
	// 게시판 댓글 삭제하기
	public void updateComment(EgovMap map) throws Exception{
		update("RecsroomDAO.updateComment", map);
	}

}
