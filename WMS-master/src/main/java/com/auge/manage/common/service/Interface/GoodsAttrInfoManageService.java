package com.auge.manage.common.service.Interface;


import com.auge.manage.domain.GoodsAttrInfo;
import com.auge.manage.exception.GoodsAttrInfoManageServiceException;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * 商品信息管理 service
 *
 * @author wm
 */
public interface GoodsAttrInfoManageService {

    /**
     * 返回指定name 商品信息记录
     * @param keyWord     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectGoodsAttrInfo(String keyWord) throws GoodsAttrInfoManageServiceException;

/*    *//**
     * 返回指定 goodsInfo name 的客户记录
     * 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param name         名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectByName(int offset, int limit, String name) throws GoodsAttrInfoManageServiceException;

    /**
     * 返回指定 goodsInfo Name 的客户记录
     * 支持模糊查询
     *
     * @param name 名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectByName(String name) throws GoodsAttrInfoManageServiceException;

    /**
     * 分页查询的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectAll(int offset, int limit) throws GoodsAttrInfoManageServiceException;

    /**
     * 查询所有的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    Map<String, Object> selectAll() throws GoodsAttrInfoManageServiceException;

    /**
     * 添加信息
     *
     * @param goodsInfo 信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean addGoodsAttrInfo(GoodsAttrInfo goodsInfo) throws GoodsAttrInfoManageServiceException;

    /**
     * 更新客户信息
     *
     * @param goodsInfo 客户信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean updateGoodsAttrInfo(GoodsAttrInfo goodsInfo) throws GoodsAttrInfoManageServiceException;

    /**
     * 删除客信息
     *
     * @param ID ID
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    boolean deleteGoodsAttrInfo(Integer ID) throws GoodsAttrInfoManageServiceException;

    /**
     * 从文件中导入客户信息
     *
     * @param file 导入信息的文件
     * @return 返回一个Map，其中：key为total代表导入的总记录数，key为available代表有效导入的记录数
     */
    Map<String, Object> importGoodsAttrInfo(MultipartFile file) throws GoodsAttrInfoManageServiceException;

    /**
     * 导出信息到文件中
     *
     * @param goodsInfos 包含若干条 goodsInfo 信息的 List
     * @return Excel 文件
     */
    File exportGoodsAttrInfo(List<GoodsAttrInfo> goodsInfos);
}
