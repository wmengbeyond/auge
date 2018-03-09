package com.auge.manage.dao;

import com.auge.manage.domain.GoodsCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品类别信息映射器
 *
 * @author wm
 * @since 2018/2/26.
 */
public interface GoodsCategoryMapper {

    /**
     * 选择所有的 GoodsCategory
     * @return 返回所有的 GoodsCategory
     */
    List<GoodsCategory> selectAll();

    /**
     * 选择指定 goodsCategory name 的 GoodsCategory
     * 与 selectByName 方法的区别在于本方法将返回相似匹配的结果
     * @param code GoodsCategory 类别编码
     * @return 返回模糊匹配指定goodsCategoryName 对应的 GoodsCategory
     */
    List<GoodsCategory> selectApproximateByName(String code);

    /**
     * 插入一个 goodsCategory 对象信息
     * 不需指定对象的主键id，数据库自动生成
     *
     * @param record 需要插入的商品类别信息
     */
    void addGoodsCategory(GoodsCategory record);


    /**
     * 更新 GoodsCategory 到数据库
     * 该 Customer 必须已经存在于数据库中，即已经分配主键，否则将更新失败
     * @param record GoodsCategory 实例
     */
    void updateGoodsCategory(GoodsCategory record);

    /**
     * 选择指定商品类别名称记录
     * @param name   类别名称
     * @return 返回所有符合条件的记录
     */
    List<GoodsCategory> selectGoodsCategory(@Param("name") String name);

    /**
     * 选择指定商品类别名称记录
     * @param type   类别名称
     * @return 返回所有符合条件的记录
     */
    List<String> selectGoodsCategoryName(@Param("type") String type);

    Long selectMaxID();

    /**
     * 选择指定 GoodsCategory name 的 goodsCategory
     * @param name 客户的名称
     * @return 返回指定 name 对应的 GoodsCategory
     */
    GoodsCategory selectByName(String name);

    /**
     * 批量插入 GoodsCategory 到数据库中
     * @param goodsCategorys 存放 GoodsCategory 实例的 List
     */
    void insertBatch(List<GoodsCategory> goodsCategorys);

    /**
     * 删除指定 id 的 GoodsCategory
     * @param id GoodsCategory ID
     */
    void deleteById(Integer id);
}
