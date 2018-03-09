package com.auge.manage.common.service.Impl;


import com.auge.manage.common.service.Interface.GoodsCategoryManageService;
import com.auge.manage.common.util.EJConvertor;
import com.auge.manage.common.util.FileUtil;
import com.auge.manage.dao.GoodsCategoryMapper;
import com.auge.manage.domain.GoodsCategory;
import com.auge.manage.exception.GoodsCategoryManageServiceException;
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
 * 商品类别信息管理 service 实现类
 *
 * @author WM
 */
@Service
public class GoodsCategoryManageServiceImpl implements GoodsCategoryManageService {

    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;
    @Autowired
    private EJConvertor ejConvertor;

    private static final String STR_FORMAT = "000";

    /**
     * 返回指定name 商品类别信息记录
     * @param type     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectGoodsCategoryName(String type) throws GoodsCategoryManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<String> goodsCategoryType;

        // 查询
        try {
            goodsCategoryType = goodsCategoryMapper.selectGoodsCategoryName(type);
        } catch (PersistenceException e) {
            System.out.println("exception catch");
            e.printStackTrace();
            throw new GoodsCategoryManageServiceException(e);
        }

        resultSet.put("data", goodsCategoryType);
        resultSet.put("total", goodsCategoryType.size());
        return resultSet;
    }

    /**
     * 返回指定name 商品类别信息记录
     * @param keyWord     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectGoodsCategory(String keyWord) throws GoodsCategoryManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<GoodsCategory> goodsCategorys;

        // 查询
        try {
            goodsCategorys = goodsCategoryMapper.selectGoodsCategory(keyWord);
        } catch (PersistenceException e) {
            System.out.println("exception catch");
            e.printStackTrace();
            throw new GoodsCategoryManageServiceException(e);
        }

        resultSet.put("data", goodsCategorys);
        resultSet.put("total", goodsCategorys.size());
        return resultSet;
    }

    /**
     * 返回指定 customer name 的客户记录 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param name         类别名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectByName(int offset, int limit, String name) throws GoodsCategoryManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<GoodsCategory> goodsGategorys;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                goodsGategorys = goodsCategoryMapper.selectApproximateByName(name);
                if (goodsGategorys != null) {
                    PageInfo<GoodsCategory> pageInfo = new PageInfo<>(goodsGategorys);
                    total = pageInfo.getTotal();
                } else
                    goodsGategorys = new ArrayList<>();
            } else {
                goodsGategorys = goodsCategoryMapper.selectApproximateByName(name);
                if (goodsGategorys != null)
                    total = goodsGategorys.size();
                else
                    goodsGategorys = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new GoodsCategoryManageServiceException(e);
        }

        resultSet.put("data", goodsGategorys);
        resultSet.put("total", total);
        return resultSet;
    }

    /**
     * 返回指定 code 的客户记录 支持模糊查询
     *
     * @param name 类别名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectByName(String name) throws GoodsCategoryManageServiceException {
        return selectByName(-1, -1, name);
    }

    /**
     * 分页查询类别的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws GoodsCategoryManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<GoodsCategory> goodsGategorys;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                goodsGategorys = goodsCategoryMapper.selectAll();
                if (goodsGategorys != null) {
                    PageInfo<GoodsCategory> pageInfo = new PageInfo<>(goodsGategorys);
                    total = pageInfo.getTotal();
                } else
                    goodsGategorys = new ArrayList<>();
            } else {
                goodsGategorys = goodsCategoryMapper.selectAll();
                if (goodsGategorys != null)
                    total = goodsGategorys.size();
                else
                    goodsGategorys = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new GoodsCategoryManageServiceException(e);
        }

        resultSet.put("data", goodsGategorys);
        resultSet.put("total", total);
        return resultSet;
    }

    /**
     * 查询所有客户的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectAll() throws GoodsCategoryManageServiceException {
        return selectAll(-1, -1);
    }

    /**
     * 检查类别信息是否满足要求
     *
     * @param goodsGategory 类别信息实体
     * @return 返回是否满足要求
     */
    private boolean goodsGategoryCheck(GoodsCategory goodsGategory) {
        return goodsGategory.getName() != null && goodsGategory.getType() != null;
    }

    /**
     * 添加商品类别信息
     *
     * @param goodsGategory 类别信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "添加商品类别信息")
    @Override
    public boolean addGoodsCategory(GoodsCategory goodsGategory) throws GoodsCategoryManageServiceException {

        // 插入新的记录
        if (goodsGategory != null) {
            // 验证
            if (goodsGategoryCheck(goodsGategory)) {
                try {
                    Long id = goodsCategoryMapper.selectMaxID();
                    DecimalFormat df = new DecimalFormat(STR_FORMAT);
                    String strCode = "LB" + df.format(++id);
                    goodsGategory.setCode(strCode);

                    long ts = System.currentTimeMillis();
                    goodsGategory.setCtime(ts);
                    goodsGategory.setMtime(ts);

                    goodsCategoryMapper.addGoodsCategory(goodsGategory);
                    return true;
                } catch (PersistenceException e) {
                    throw new GoodsCategoryManageServiceException(e);
                }
            }
        }
        return false;
    }

    /**
     * 更新商品类别信息
     *
     * @param goodsGategory 类别信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "修改商品类别信息")
    @Override
    public boolean updateGoodsCategory(GoodsCategory goodsGategory) throws GoodsCategoryManageServiceException {

        // 更新记录
        if (goodsGategory != null) {
            // 检验
            if (goodsGategoryCheck(goodsGategory)) {
                try {
                    long ts = System.currentTimeMillis();
                    goodsGategory.setMtime(ts);
                    goodsCategoryMapper.updateGoodsCategory(goodsGategory);
                    return true;
                } catch (PersistenceException e) {
                    throw new GoodsCategoryManageServiceException(e);
                }
            }
        }
        return false;
    }

    /**
     * 删除客户信息
     *
     * @param ID 类别ID
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "删除客户信息")
    @Override
    public boolean deleteGoodsCategory(Integer ID) throws GoodsCategoryManageServiceException {

        try {
            // 删除该条客户记录
            goodsCategoryMapper.deleteById(ID);
            return true;
        } catch (PersistenceException e) {
            throw new GoodsCategoryManageServiceException(e);
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
    public Map<String, Object> importGoodsCategory(MultipartFile file) throws GoodsCategoryManageServiceException {
        // 初始化结果集
        Map<String, Object> result = new HashMap<>();
        int total = 0;
        int available = 0;

        // 从 Excel 文件中读取
        try {
            List<GoodsCategory> goodsGategorys = ejConvertor.excelReader(GoodsCategory.class, FileUtil.convertMultipartFileToFile(file));
            if (goodsGategorys != null) {
                total = goodsGategorys.size();

                // 验证每一条记录
                List<GoodsCategory> availableList = new ArrayList<>();
                for (GoodsCategory goodsGategory : goodsGategorys) {
                    if (goodsGategoryCheck(goodsGategory)) {
                        //if (goodsGategoryMapper.selectByName(goodsGategory.getName()) == null)
                            availableList.add(goodsGategory);
                    }
                }

                // 保存到数据库
                available = availableList.size();
                if (available > 0) {
                    goodsCategoryMapper.insertBatch(availableList);
                }
            }
        } catch (PersistenceException | IOException e) {
            throw new GoodsCategoryManageServiceException(e);
        }

        result.put("total", total);
        result.put("available", available);
        return result;
    }

    /**
     * 导出类别信息到文件中
     *
     * @param goodsGategorys 包含若干条 goodsGategory 信息的 List
     * @return Excel 文件
     */
    @UserOperation(value = "导出类别信息")
    @Override
    public File exportGoodsCategory(List<GoodsCategory> goodsGategorys) {
        if (goodsGategorys == null)
            return null;

        return ejConvertor.excelWriter(GoodsCategory.class, goodsGategorys);
    }
}
