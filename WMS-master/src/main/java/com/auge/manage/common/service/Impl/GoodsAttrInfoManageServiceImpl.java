package com.auge.manage.common.service.Impl;


import com.auge.manage.common.service.Interface.GoodsAttrInfoManageService;
import com.auge.manage.common.util.EJConvertor;
import com.auge.manage.common.util.FileUtil;
import com.auge.manage.dao.GoodsAttrInfoMapper;
import com.auge.manage.domain.GoodsAttrInfo;
import com.auge.manage.exception.GoodsAttrInfoManageServiceException;
import com.auge.manage.util.aop.UserOperation;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商品信息管理 service 实现类
 *
 * @author WM
 */
@Service
public class GoodsAttrInfoManageServiceImpl implements GoodsAttrInfoManageService {

    @Autowired
    private GoodsAttrInfoMapper goodsAttrInfoMapper;
    @Autowired
    private EJConvertor ejConvertor;

    private static final String STR_FORMAT = "000";

    /**
     * 返回指定name 商品信息记录
     * @param keyWord     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectGoodsAttrInfo(String keyWord) throws GoodsAttrInfoManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<GoodsAttrInfo> goodsAttrInfos;

        // 查询
        try {
            goodsAttrInfos = goodsAttrInfoMapper.selectGoodsAttrInfo(keyWord);
        } catch (PersistenceException e) {
            System.out.println("exception catch");
            e.printStackTrace();
            throw new GoodsAttrInfoManageServiceException(e);
        }

        resultSet.put("data", goodsAttrInfos);
        resultSet.put("total", goodsAttrInfos.size());
        return resultSet;
    }

    /**
     * 返回指定 customer name 的客户记录 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param name         名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectByName(int offset, int limit, String name) throws GoodsAttrInfoManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<GoodsAttrInfo> goodsAttrInfos;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                goodsAttrInfos = goodsAttrInfoMapper.selectApproximateByName(name);
                if (goodsAttrInfos != null) {
                    PageInfo<GoodsAttrInfo> pageInfo = new PageInfo<>(goodsAttrInfos);
                    total = pageInfo.getTotal();
                } else
                    goodsAttrInfos = new ArrayList<>();
            } else {
                goodsAttrInfos = goodsAttrInfoMapper.selectApproximateByName(name);
                if (goodsAttrInfos != null)
                    total = goodsAttrInfos.size();
                else
                    goodsAttrInfos = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new GoodsAttrInfoManageServiceException(e);
        }

        resultSet.put("data", goodsAttrInfos);
        resultSet.put("total", total);
        return resultSet;
    }

    /**
     * 返回指定 code 的客户记录 支持模糊查询
     *
     * @param name 名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectByName(String name) throws GoodsAttrInfoManageServiceException {
        return selectByName(-1, -1, name);
    }

    /**
     * 分页查询的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws GoodsAttrInfoManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<GoodsAttrInfo> goodsAttrInfos;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                goodsAttrInfos = goodsAttrInfoMapper.selectAll();
                if (goodsAttrInfos != null) {
                    PageInfo<GoodsAttrInfo> pageInfo = new PageInfo<>(goodsAttrInfos);
                    total = pageInfo.getTotal();
                } else
                    goodsAttrInfos = new ArrayList<>();
            } else {
                goodsAttrInfos = goodsAttrInfoMapper.selectAll();
                if (goodsAttrInfos != null)
                    total = goodsAttrInfos.size();
                else
                    goodsAttrInfos = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new GoodsAttrInfoManageServiceException(e);
        }

        resultSet.put("data", goodsAttrInfos);
        resultSet.put("total", total);
        return resultSet;
    }

    /**
     * 查询所有客户的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectAll() throws GoodsAttrInfoManageServiceException {
        return selectAll(-1, -1);
    }

    /**
     * 检查信息是否满足要求
     *
     * @param goodsAttrInfo 信息实体
     * @return 返回是否满足要求
     */
    private boolean goodsAttrInfoCheck(GoodsAttrInfo goodsAttrInfo) {
        return goodsAttrInfo.getName() != null && goodsAttrInfo.getAlias() != null;
    }

    /**
     * 添加商品信息
     *
     * @param goodsAttrInfo 信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "添加商品信息")
    @Override
    public boolean addGoodsAttrInfo(GoodsAttrInfo goodsAttrInfo) throws GoodsAttrInfoManageServiceException {

        // 插入新的记录
        if (goodsAttrInfo != null) {
            // 验证
            if (goodsAttrInfoCheck(goodsAttrInfo)) {
                try {
                    Long id = goodsAttrInfoMapper.selectMaxID();
                    DecimalFormat df = new DecimalFormat(STR_FORMAT);
                    String strCode = "MC" + df.format(++id);
                    goodsAttrInfo.setCode(strCode);

                    long ts = System.currentTimeMillis();
                    goodsAttrInfo.setCtime(ts);
                    goodsAttrInfo.setMtime(ts);

                    goodsAttrInfoMapper.addGoodsAttrInfo(goodsAttrInfo);
                    return true;
                } catch (PersistenceException e) {
                    throw new GoodsAttrInfoManageServiceException(e);
                }
            }
        }
        return false;
    }

    /**
     * 更新商品信息
     *
     * @param goodsAttrInfo 信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "修改商品信息")
    @Override
    public boolean updateGoodsAttrInfo(GoodsAttrInfo goodsAttrInfo) throws GoodsAttrInfoManageServiceException {

        // 更新记录
        if (goodsAttrInfo != null) {
            // 检验
            if (goodsAttrInfoCheck(goodsAttrInfo)) {
                try {
                    long ts = System.currentTimeMillis();
                    goodsAttrInfo.setMtime(ts);
                    goodsAttrInfoMapper.updateGoodsAttrInfo(goodsAttrInfo);
                    return true;
                } catch (PersistenceException e) {
                    throw new GoodsAttrInfoManageServiceException(e);
                }
            }
        }
        return false;
    }

    /**
     * 删除客户信息
     *
     * @param ID ID
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "删除客户信息")
    @Override
    public boolean deleteGoodsAttrInfo(Integer ID) throws GoodsAttrInfoManageServiceException {

        try {
            // 删除该条客户记录
            goodsAttrInfoMapper.deleteById(ID);
            return true;
        } catch (PersistenceException e) {
            throw new GoodsAttrInfoManageServiceException(e);
        }
    }

    /**
     * 从文件中导入客户信息
     *
     * @param file 导入信息的文件
     * @return 返回一个Map，其中：key为total代表导入的总记录数，key为available代表有效导入的记录数
     */
    @UserOperation(value = "导入客户信息")
    @Override
    public Map<String, Object> importGoodsAttrInfo(MultipartFile file) throws GoodsAttrInfoManageServiceException {
        // 初始化结果集
        Map<String, Object> result = new HashMap<>();
        int total = 0;
        int available = 0;

        // 从 Excel 文件中读取
        try {
            List<GoodsAttrInfo> goodsAttrInfos = ejConvertor.excelReader(GoodsAttrInfo.class, FileUtil.convertMultipartFileToFile(file));
            if (goodsAttrInfos != null) {
                total = goodsAttrInfos.size();

                // 验证每一条记录
                List<GoodsAttrInfo> availableList = new ArrayList<>();
                for (GoodsAttrInfo goodsAttrInfo : goodsAttrInfos) {
                    if (goodsAttrInfoCheck(goodsAttrInfo)) {
                        //if (goodsAttrInfoMapper.selectByName(goodsAttrInfo.getName()) == null)
                            availableList.add(goodsAttrInfo);
                    }
                }

                // 保存到数据库
                available = availableList.size();
                if (available > 0) {
                    goodsAttrInfoMapper.insertBatch(availableList);
                }
            }
        } catch (PersistenceException | IOException e) {
            throw new GoodsAttrInfoManageServiceException(e);
        }

        result.put("total", total);
        result.put("available", available);
        return result;
    }

    /**
     * 导出信息到文件中
     *
     * @param goodsAttrInfos 包含若干条 goodsAttrInfo 信息的 List
     * @return Excel 文件
     */
    @UserOperation(value = "导出信息")
    @Override
    public File exportGoodsAttrInfo(List<GoodsAttrInfo> goodsAttrInfos) {
        if (goodsAttrInfos == null)
            return null;

        return ejConvertor.excelWriter(GoodsAttrInfo.class, goodsAttrInfos);
    }
}
