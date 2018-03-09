package com.auge.manage.dao;

import com.auge.manage.domain.Brand;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品品牌信息映射器
 *
 * @author wm
 * @since 2018/2/26.
 */
public interface BrandMapper {

    /**
     * 选择所有的 Customer
     * @return 返回所有的 Customer
     */
    List<Brand> selectAll();

    /**
     * 选择指定 customer name 的 Customer
     * 与 selectByName 方法的区别在于本方法将返回相似匹配的结果
     * @param code Customer 供应商名
     * @return 返回模糊匹配指定customerName 对应的Customer
     */
    List<Brand> selectApproximateByName(String code);

    /**
     * 插入一个 brand 对象信息
     * 不需指定对象的主键id，数据库自动生成
     *
     * @param record 需要插入的商品品牌信息
     */
    void addBrand(Brand record);


    /**
     * 更新 Brand 到数据库
     * 该 Customer 必须已经存在于数据库中，即已经分配主键，否则将更新失败
     * @param record Brand 实例
     */
    void updateBrand(Brand record);

    /**
     * 选择指定商品品牌名称记录
     * @param name   品牌名称
     * @return 返回所有符合条件的记录
     */
    List<Brand> selectBrand(@Param("name") String name);

    Long selectMaxID();

    /**
     * 选择指定 Brand name 的 brand
     * @param name 客户的名称
     * @return 返回指定 name 对应的 Brand
     */
    Brand selectByName(String name);

    /**
     * 批量插入 Brand 到数据库中
     * @param brands 存放 Brand 实例的 List
     */
    void insertBatch(List<Brand> brands);

    /**
     * 删除指定 id 的 Brand
     * @param id Brand ID
     */
    void deleteById(Integer id);
}
