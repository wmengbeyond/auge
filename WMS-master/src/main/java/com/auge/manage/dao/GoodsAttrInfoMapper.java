package com.auge.manage.dao;

import com.auge.manage.domain.GoodsAttrInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品信息映射器
 *
 * @author wm
 * @since 2018/2/26.
 */
public interface GoodsAttrInfoMapper {

    /**
     * 选择所有的 Info
     * @return 返回所有的 Info
     */
    List<GoodsAttrInfo> selectAll();

    /**
     * 选择指定 info name 的 Info
     * 与 selectByName 方法的区别在于本方法将返回相似匹配的结果
     * @param code Info 供应商名
     * @return 返回模糊匹配指定infoName 对应的Info
     */
    List<GoodsAttrInfo> selectApproximateByName(String code);

    /**
     * 插入一个 goodsInfo 对象信息
     * 不需指定对象的主键id，数据库自动生成
     *
     * @param record 需要插入的商品信息
     */
    void addGoodsAttrInfo(GoodsAttrInfo record);


    /**
     * 更新 GoodsAttrInfo 到数据库
     * 该 Info 必须已经存在于数据库中，即已经分配主键，否则将更新失败
     * @param record GoodsAttrInfo 实例
     */
    void updateGoodsAttrInfo(GoodsAttrInfo record);

    /**
     * 选择指定商品名称记录
     * @param name   名称
     * @return 返回所有符合条件的记录
     */
    List<GoodsAttrInfo> selectGoodsAttrInfo(@Param("name") String name);

    /**
     * @return 返回最大记录
     */
    Long selectMaxID();

    /**
     * 选择指定 GoodsAttrInfo name 的 goodsInfo
     * @param name 客户的名称
     * @return 返回指定 name 对应的 GoodsAttrInfo
     */
    GoodsAttrInfo selectByName(String name);

    /**
     * 批量插入 GoodsAttrInfo 到数据库中
     * @param goodsAttrInfos 存放 GoodsAttrInfo 实例的 List
     */
    void insertBatch(List<GoodsAttrInfo> goodsAttrInfos);

    /**
     * 删除指定 id 的 GoodsAttrInfo
     * @param id GoodsAttrInfo ID
     */
    void deleteById(Integer id);
}
