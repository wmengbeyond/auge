package com.auge.manage.common.service.Interface;


import com.auge.manage.domain.Brand;
import com.auge.manage.exception.BrandManageServiceException;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * 商品品牌信息管理 service
 *
 * @author wm
 */
public interface BrandManageService {

    /**
     * 返回指定name 商品品牌信息记录
     * @param keyWord     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectBrand(String keyWord) throws BrandManageServiceException;

/*    *//**
     * 返回指定 customer name 的客户记录
     * 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param name         品牌名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectByName(int offset, int limit, String name) throws BrandManageServiceException;

    /**
     * 返回指定 customer Name 的客户记录
     * 支持模糊查询
     *
     * @param name 品牌名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectByName(String name) throws BrandManageServiceException;

    /**
     * 分页查询品牌的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectAll(int offset, int limit) throws BrandManageServiceException;

    /**
     * 查询所有品牌的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectAll() throws BrandManageServiceException;

    /**
     * 添加信息
     *
     * @param brand 信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean addBrand(Brand brand) throws BrandManageServiceException;

    /**
     * 更新客户信息
     *
     * @param brand 客户信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean updateBrand(Brand brand) throws BrandManageServiceException;

    /**
     * 删除客品牌信息
     *
     * @param ID 品牌ID
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean deleteBrand(Integer ID) throws BrandManageServiceException;

    /**
     * 从文件中导入客户信息
     *
     * @param file 导入信息的文件
     * @return 返回一个Map，其中：key为total代表导入的总记录数，key为available代表有效导入的记录数
     */
    Map<String, Object> importBrand(MultipartFile file) throws BrandManageServiceException;

    /**
     * 导出品牌信息到文件中
     *
     * @param brands 包含若干条 brand 信息的 List
     * @return Excel 文件
     */
    File exportBrand(List<Brand> brands);
}
