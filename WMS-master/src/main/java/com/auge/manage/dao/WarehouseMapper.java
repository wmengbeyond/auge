package com.auge.manage.dao;

import com.auge.manage.domain.Warehouse;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 中心仓库数据记录因映射器
 *
 * @author wm
 * @since 2018/2/6.
 */
public interface WarehouseMapper {

    /**
     * 插入一个 warehouse 对象信息
     * 不需指定对象的主键id，数据库自动生成
     *
     * @param whRecord 需要插入的中心仓库信息
     */
    void insertWarehouse(Warehouse whRecord);

    /**
     * 选择指定用户ID、记录类型、时间范围的登入登出记录
     *
     * @param name      名称
     * @param contact   联系人
     * @param code      编码
     * @return 返回所有符合条件的记录
     */
    List<Warehouse> selectWarehouse(@Param("name") String name,
                                        @Param("contact") String contact,
                                        @Param("code") String code);
}
