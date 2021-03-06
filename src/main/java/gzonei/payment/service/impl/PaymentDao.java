package gzonei.payment.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("PaymentDao")
public class PaymentDao extends EgovComAbstractDAO {

	/** 희진 */
	public List<?> selectExcclcList(EgovMap map) throws SQLException, IOException {
        return selectList("PaymentDao.selectExcclcList", map);
    }
	
	public int selectExcclcListTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("PaymentDao.selectExcclcListTotCnt", map);
	}
	
	public int insertExcclcInfo(Map<String, Object> map) throws SQLException, IOException {
		return insert("PaymentDao.insertExcclcInfo", map);
	}
	
	public EgovMap selectExcclcDetail(EgovMap map) throws SQLException, IOException {
		return selectOne("PaymentDao.selectExcclcDetail", map);
	}
	
	public int updateExcclcInfo(Map<String, Object> map) throws SQLException, IOException {
		return update("PaymentDao.updateExcclcInfo", map);
	}
	
	public List<?> selectNbkkCnfirmList(EgovMap map) throws SQLException, IOException {
		return selectList("PaymentDao.selectNbkkCnfirmList", map);
	}
	
	public int selectNbkkCnfirmListTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("PaymentDao.selectNbkkCnfirmListTotCnt", map);
	}
}
