package gzonei.gradAuth.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
@Repository("BsnsDstrcDAO")
public class BsnsDstrcDAO extends EgovComAbstractDAO {

	public List<?> selectBsnsDstrc() {
		// TODO Auto-generated method stub
		return selectList("BsnsDstrcDAO.selectBsnsDstrc");
	}

	public void updateBsnsDstrc(EgovMap vo) {
		// TODO Auto-generated method stub
		update("BsnsDstrcDAO.updateBsnsDstrc",vo);
		
	}

	public void deleteBsnsDstrc(EgovMap vo) {
		// TODO Auto-generated method stub
		
	}

	public void createBsnsDstrc(EgovMap vo) {
		// TODO Auto-generated method stub
		insert("BsnsDstrcDAO.insertBsnsDstrc",vo);
	}

	public List<?> selectDstrcAuthor() {
		// TODO Auto-generated method stub
		return selectList("BsnsDstrcDAO.selectDstrcAuthor");
	}

	public void updateCodeChecker(EgovMap vo) {
		// TODO Auto-generated method stub
		update("BsnsDstrcDAO.updateCodeChecker",vo);
		update("BsnsDstrcDAO.updateDevinfo",vo);
	}

}
