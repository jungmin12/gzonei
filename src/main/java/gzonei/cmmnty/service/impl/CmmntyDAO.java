package gzonei.cmmnty.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
@Repository("CmmntyDAO")
public class CmmntyDAO extends EgovComAbstractDAO{

	public List<?> selectArticleList(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectList("CmmntyDAO.selectList",searchVO);
	}

	public List<?> selectTabArticleList(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectList("CmmntyDAO.selectTabList",searchVO);
	}

	public EgovMap selectDetail(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("CmmntyDAO.selectDetail",searchVO);
	}

	public int selectListTotCnt(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("CmmntyDAO.selectListCnt",searchVO);
	}

	public int selectTabListTotCnt(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("CmmntyDAO.selectTabListCnt",searchVO);
	}

	public int insertArticle(Map<String, Object> commandMap) {
		// TODO Auto-generated method stub
		return insert("CmmntyDAO.inserArticle",commandMap);
	}

	public int deleteArticle(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return update("CmmntyDAO.deleteArticle",searchVO);
	}

	public int updateArticle(Map<String, Object> commandMap) {
		// TODO Auto-generated method stub
		return update("CmmntyDAO.updateArticle",commandMap);
	}

	public int updateBbsRdcnt(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return update("CmmntyDAO.updateViewCount",searchVO);
	}

	public List<?> selectComment(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectList("CmmntyDAO.selectCommentList",searchVO);
	}

	public void insertComment(EgovMap commentVO) {
		// TODO Auto-generated method stub
		insert("CmmntyDAO.insertComment",commentVO);
	}

	public void deleteComment(EgovMap commentVO) {
		// TODO Auto-generated method stub
		update("CmmntyDAO.deleteComment",commentVO);
	}

	public void updateComment(EgovMap commentVO) {
		// TODO Auto-generated method stub
		update("CmmntyDAO.updateComment",commentVO);
	}

	public void answerCheck(EgovMap commentVO) {
		// TODO Auto-generated method stub
		update("CmmntyDAO.answerCheck",commentVO);
	}

	public List<?> selectNoticeList(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectList("CmmntyDAO.selectNoticeList",searchVO);
	}
	
	public List<?> selectNewsList(EgovMap searchVO){
		return selectList("CmmntyDAO.selectNewsList", searchVO);
	}

}
