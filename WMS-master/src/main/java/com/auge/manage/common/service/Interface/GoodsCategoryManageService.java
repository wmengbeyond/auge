package com.auge.manage.common.service.Interface;


import com.auge.manage.domain.GoodsCategory;
import com.auge.manage.exception.GoodsCategoryManageServiceException;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * 商品类别信息管理 service
 *
 * @author wm
 */
public interface GoodsCategoryManageService {

    /**
     * 返回指定name 商品类别信息记录
     * @param type     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectGoodsCategoryName(String type) throws GoodsCategoryManageServiceException;

    /**
     * 返回指定name 商品类别信息记录
     * @param keyWord     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectGoodsCategory(String keyWord) throws GoodsCategoryManageServiceException;

/*    *//**
     * 返回指定 goodsCategory name 的客户记录
     * 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param name         类别名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectByName(int offset, int limit, String name) throws GoodsCategoryManageServiceException;

    /**
     * 返回指定 goodsCategory Name 的客户记录
     * 支持模糊查询
     *
     * @param name 类别名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectByName(String name) throws GoodsCategoryManageServiceException;

    /**
     * 分页查询类别的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectAll(int offset, int limit) throws GoodsCategoryManageServiceException;

    /**
     * 查询所有类别的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectAll() throws GoodsCategoryManageServiceException;

    /**
     * 添加信息
     *
     * @param goodsCategory 信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean addGoodsCategory(GoodsCategory goodsCategory) throws GoodsCategoryManageServiceException;

    /**
     * 更新客户信息
     *
     * @param goodsCategory 客户信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean updateGoodsCategory(GoodsCategory goodsCategory) throws GoodsCategoryManageServiceException;

    /**
     * 删除客类别信息
     *
     * @param ID 类别ID
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean deleteGoodsCategory(Integer ID) throws GoodsCategoryManageServiceException;

    /**
     * 从文件中导入客户信息
     *
     * @param file 导入信息的文件
     * @return 返回一个Map，其中：key为total代表导入的总记录数，key为available代表有效导入的记录数
     */
    Map<String, Object> importGoodsCategory(MultipartFile file) throws GoodsCategoryManageServiceException;

    /**
     * 导出类别信息到文件中
     *
     * @param goodsCategorys 包含若干条 goodsCategory 信息的 List
     * @return Excel 文件
     */
    File exportGoodsCategory(List<GoodsCategory> goodsCategorys);
}
