package gzonei.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("SampleDAO")
public class SampleDAO extends EgovComAbstractDAO {

	public List<?> selectSampleList(EgovMap map) throws Exception {
        return selectList("SampleDAO.selectSampleList", map);
    }
	
	public List<?> selectSampleExcel(EgovMap map) throws Exception {
		return selectList("SampleDAO.selectSampleExcel", map);
	}

	public List<?> selectViewLayer(EgovMap searchVO) throws Exception {
		// TODO Auto-generated method stub
		return selectList("SampleDAO.selectViewLayer", searchVO);
	}

	public void insertLayer(EgovMap searchVO) throws Exception{
		insert("SampleDAO.insertLayer", searchVO);
		
	}

	public void updateLayer(EgovMap searchVO) throws Exception{
		// TODO Auto-generated method stub
		
		update("SampleDAO.updateLayer", searchVO);
		
	}

	public void deleteLayer(EgovMap searchVO) throws Exception{
		// TODO Auto-generated method stub
		delete("SampleDAO.deleteLayer", searchVO);
	}

}
