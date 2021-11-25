package gzonei.today.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("TodayAdminDao")
public class TodayAdminDao extends EgovComAbstractDAO {

	/** 희진 */
	public List<?> selectPrtnSttusList(EgovMap map) throws SQLException, IOException {
        return selectList("TodayAdminDao.selectPrtnSttusList", map);
    }
	
	public int selectPrtnSttusListTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("TodayAdminDao.selectPrtnSttusListTotCnt", map);
	}
	
	public List<?> selectPrtnSttusListExcel(EgovMap map) throws SQLException, IOException {
		return selectList("TodayAdminDao.selectPrtnSttusListExcel", map);
	}
	
	public List<?> selectDevelopGosiList(EgovMap map) throws SQLException, IOException {
        return selectList("TodayAdminDao.selectDevelopGosiList", map);
    }
	
	public int selectDevelopGosiListTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("TodayAdminDao.selectDevelopGosiListTotCnt", map);
	}
	
	/** 다현 */
	public List<?> selectTodayDevInfoList(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("TodayAdminDao.selectTodayDevInfoList",map);
	}

	public int selectTodayDevInfoTotCnt(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("TodayAdminDao.selectTodayDevInfoTotCnt",map);
	}

	public EgovMap selectReqDevInfo(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("TodayAdminDao.selectReqDevInfo",map);
	}

	public int udtDevlopInfo(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("TodayAdminDao.udtDevlopInfo",map);
	}
}
