package com.auge.manage.common.service.Impl;


import com.auge.manage.common.service.Interface.BrandManageService;
import com.auge.manage.common.util.EJConvertor;
import com.auge.manage.common.util.FileUtil;
import com.auge.manage.dao.BrandMapper;
import com.auge.manage.domain.Brand;
import com.auge.manage.exception.BrandManageServiceException;
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
 * 客户信息管理 service 实现类
 *
 * @author WM
 */
@Service
public class BrandManageServiceImpl implements BrandManageService {

    @Autowired
    private BrandMapper brandMapper;
    @Autowired
    private EJConvertor ejConvertor;

    private static final String STR_FORMAT = "000";

    /**
     * 返回指定name 商品品牌信息记录
     * @param keyWord     关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectBrand(String keyWord) throws BrandManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Brand> brands;

        // 查询
        try {
            brands = brandMapper.selectBrand(keyWord);
        } catch (PersistenceException e) {
            System.out.println("exception catch");
            e.printStackTrace();
            throw new BrandManageServiceException(e);
        }

        resultSet.put("data", brands);
        resultSet.put("total", brands.size());
        return resultSet;
    }

    /**
     * 返回指定 customer name 的客户记录 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param name         品牌名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectByName(int offset, int limit, String name) throws BrandManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Brand> brands;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                brands = brandMapper.selectApproximateByName(name);
                if (brands != null) {
                    PageInfo<Brand> pageInfo = new PageInfo<>(brands);
                    total = pageInfo.getTotal();
                } else
                    brands = new ArrayList<>();
            } else {
                brands = brandMapper.selectApproximateByName(name);
                if (brands != null)
                    total = brands.size();
                else
                    brands = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BrandManageServiceException(e);
        }

        resultSet.put("data", brands);
        resultSet.put("total", total);
        return resultSet;
    }

    /**
     * 返回指定 code 的客户记录 支持模糊查询
     *
     * @param name 品牌名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectByName(String name) throws BrandManageServiceException {
        return selectByName(-1, -1, name);
    }

    /**
     * 分页查询品牌的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws BrandManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Brand> brands;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                brands = brandMapper.selectAll();
                if (brands != null) {
                    PageInfo<Brand> pageInfo = new PageInfo<>(brands);
                    total = pageInfo.getTotal();
                } else
                    brands = new ArrayList<>();
            } else {
                brands = brandMapper.selectAll();
                if (brands != null)
                    total = brands.size();
                else
                    brands = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BrandManageServiceException(e);
        }

        resultSet.put("data", brands);
        resultSet.put("total", total);
        return resultSet;
    }

    /**
     * 查询所有客户的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectAll() throws BrandManageServiceException {
        return selectAll(-1, -1);
    }

    /**
     * 检查品牌信息是否满足要求
     *
     * @param brand 品牌信息实体
     * @return 返回是否满足要求
     */
    private boolean brandCheck(Brand brand) {
        return brand.getName() != null && brand.getType() != null && brand.getChangjia() != null;
    }

    /**
     * 添加商品品牌信息
     *
     * @param brand 品牌信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "添加商品品牌信息")
    @Override
    public boolean addBrand(Brand brand) throws BrandManageServiceException {

        // 插入新的记录
        if (brand != null) {
            // 验证
            if (brandCheck(brand)) {
                try {
                    Long id = brandMapper.selectMaxID();
                    DecimalFormat df = new DecimalFormat(STR_FORMAT);
                    String strCode = "PP" + df.format(++id);
                    brand.setCode(strCode);

                    long ts = System.currentTimeMillis();
                    brand.setCtime(ts);
                    brand.setMtime(ts);

                    brandMapper.addBrand(brand);
                    return true;
                } catch (PersistenceException e) {
                    throw new BrandManageServiceException(e);
                }
            }
        }
        return false;
    }

    /**
     * 更新商品品牌信息
     *
     * @param brand 品牌信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "修改商品品牌信息")
    @Override
    public boolean updateBrand(Brand brand) throws BrandManageServiceException {

        // 更新记录
        if (brand != null) {
            // 检验
            if (brandCheck(brand)) {
                try {
                    long ts = System.currentTimeMillis();
                    brand.setMtime(ts);
                    brandMapper.updateBrand(brand);
                    return true;
                } catch (PersistenceException e) {
                    throw new BrandManageServiceException(e);
                }
            }
        }
        return false;
    }

    /**
     * 删除客户信息
     *
     * @param ID 品牌ID
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     */
    @UserOperation(value = "删除客户信息")
    @Override
    public boolean deleteBrand(Integer ID) throws BrandManageServiceException {

        try {
            // 删除该条客户记录
            brandMapper.deleteById(ID);
            return true;
        } catch (PersistenceException e) {
            throw new BrandManageServiceException(e);
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
    public Map<String, Object> importBrand(MultipartFile file) throws BrandManageServiceException {
        // 初始化结果集
        Map<String, Object> result = new HashMap<>();
        int total = 0;
        int available = 0;

        // 从 Excel 文件中读取
        try {
            List<Brand> brands = ejConvertor.excelReader(Brand.class, FileUtil.convertMultipartFileToFile(file));
            if (brands != null) {
                total = brands.size();

                // 验证每一条记录
                List<Brand> availableList = new ArrayList<>();
                for (Brand brand : brands) {
                    if (brandCheck(brand)) {
                        //if (brandMapper.selectByName(brand.getName()) == null)
                            availableList.add(brand);
                    }
                }

                // 保存到数据库
                available = availableList.size();
                if (available > 0) {
                    brandMapper.insertBatch(availableList);
                }
            }
        } catch (PersistenceException | IOException e) {
            throw new BrandManageServiceException(e);
        }

        result.put("total", total);
        result.put("available", available);
        return result;
    }

    /**
     * 导出品牌信息到文件中
     *
     * @param brands 包含若干条 brand 信息的 List
     * @return Excel 文件
     */
    @UserOperation(value = "导出品牌信息")
    @Override
    public File exportBrand(List<Brand> brands) {
        if (brands == null)
            return null;

        return ejConvertor.excelWriter(Brand.class, brands);
    }
}
