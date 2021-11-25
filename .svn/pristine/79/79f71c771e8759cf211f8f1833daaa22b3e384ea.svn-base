package gzonei.cmmnty.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmnty.service.CmmntyService;
import gzonei.sample.service.impl.SampleServiceImpl;
@Service("CmmntyService")
public class CmmntyServiceImpl implements CmmntyService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SampleServiceImpl.class);
	@Resource(name="CmmntyDAO")
	private CmmntyDAO cmmntyDao;
	
	@Override	
	public List<?> selectArticleList(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectArticleList(searchVO);
	}

	@Override
	public List<?> selectTabArticleList(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectTabArticleList(searchVO);
	}

	@Override
	public EgovMap selectDetail(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectDetail(searchVO);
	}

	@Override
	public int selectListTotCnt(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectListTotCnt(searchVO);
	}

	@Override
	public int selectTabListTotCnt(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectTabListTotCnt(searchVO);
	}

	@Override
	public int insertArticle(Map<String, Object> commandMap) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.insertArticle(commandMap);
	}

	@Override
	public int deleteArticle(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.deleteArticle(searchVO);
	}

	@Override
	public int updateArticle(Map<String, Object> commandMap) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.updateArticle(commandMap);
	}

	@Override
	public int updateBbsRdcnt(EgovMap searchVO) throws SQLException, IOException, Exception {
		// TODO Auto-generated method stub
		return cmmntyDao.updateBbsRdcnt(searchVO);
	}

	@Override
	public List<?> selectComment(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectComment(searchVO);
	}

	@Override
	public void insertComment(EgovMap commentVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		cmmntyDao.insertComment(commentVO);
	}

	@Override
	public void deleteComment(EgovMap commentVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		cmmntyDao.deleteComment(commentVO);
	}

	@Override
	public void updateComment(EgovMap commentVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		cmmntyDao.updateComment(commentVO);
	}

	@Override
	public void answerCheck(EgovMap commentVO) {
		// TODO Auto-generated method stub
		cmmntyDao.answerCheck(commentVO);
	}

	@Override
	public List<?> selectNoticeList(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmntyDao.selectNoticeList(searchVO);
	}
	@Override
	public List<?> selectNewsList(EgovMap searchVO) throws SQLException, IOException {
		return cmmntyDao.selectNewsList(searchVO);
	}


}
