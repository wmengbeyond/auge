package com.auge.manage.common.service.Impl;


import com.auge.manage.common.service.Interface.BaseManageService;
import com.auge.manage.common.util.EJConvertor;
import com.auge.manage.common.util.FileUtil;
import com.auge.manage.dao.WarehouseMapper;
import com.auge.manage.domain.Warehouse;
import com.auge.manage.domain.StockOutDO;
import com.auge.manage.exception.BaseManageServiceException;
import com.auge.manage.util.aop.UserOperation;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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
public class BaseManageServiceImpl implements BaseManageService {

    @Autowired
    private WarehouseMapper warehouseMapper;
    @Autowired
    private EJConvertor ejConvertor;

    /**
     * 返回指定code/ name/ contact 的中心仓库记录
     *
     * @param searchType   查询类型 1 name 2 contact 3 code
     * @param keyWord      关键字
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     */
    @Override
    public Map<String, Object> selectWarehouse(Integer searchType, String keyWord) throws BaseManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Warehouse> warehouses;

        String name = null;
        String contact = null;
        String code = null;

        switch (searchType)
        {
            case 1:
                name = keyWord;
                break;
            case 2:
                contact = keyWord;
                break;
            case 3:
                code = keyWord;
                break;
        }

        // 查询
        try {
            warehouses = warehouseMapper.selectWarehouse(name, contact, code);
        } catch (PersistenceException e) {
            System.out.println("exception catch");
            e.printStackTrace();
            throw new BaseManageServiceException(e);
        }

        resultSet.put("data", warehouses);
        resultSet.put("total", warehouses.size());
        return resultSet;
    }

    /**
     * 返回指定 customer name 的客户记录 支持查询分页以及模糊查询
     *
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @param customerName 客户的名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     *//*
    @Override
    public Map<String, Object> selectByName(int offset, int limit, String customerName) throws BaseManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Customer> customers;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                customers = warehouseMapper.selectApproximateByName(customerName);
                if (customers != null) {
                    PageInfo<Customer> pageInfo = new PageInfo<>(customers);
                    total = pageInfo.getTotal();
                } else
                    customers = new ArrayList<>();
            } else {
                customers = warehouseMapper.selectApproximateByName(customerName);
                if (customers != null)
                    total = customers.size();
                else
                    customers = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BaseManageServiceException(e);
        }

        resultSet.put("data", customers);
        resultSet.put("total", total);
        return resultSet;
    }

    *//**
     * 返回指定 customer Name 的客户记录 支持模糊查询
     *
     * @param customerName 客户名称
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     *//*
    @Override
    public Map<String, Object> selectByName(String customerName) throws BaseManageServiceException {
        return selectByName(-1, -1, customerName);
    }

    *//**
     * 分页查询客户的记录
     *
     * @param offset 分页的偏移值
     * @param limit  分页的大小
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     *//*
    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws BaseManageServiceException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Customer> customers;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                customers = warehouseMapper.selectAll();
                if (customers != null) {
                    PageInfo<Customer> pageInfo = new PageInfo<>(customers);
                    total = pageInfo.getTotal();
                } else
                    customers = new ArrayList<>();
            } else {
                customers = warehouseMapper.selectAll();
                if (customers != null)
                    total = customers.size();
                else
                    customers = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BaseManageServiceException(e);
        }

        resultSet.put("data", customers);
        resultSet.put("total", total);
        return resultSet;
    }

    *//**
     * 查询所有客户的记录
     *
     * @return 结果的一个Map，其中： key为 data 的代表记录数据；key 为 total 代表结果记录的数量
     *//*
    @Override
    public Map<String, Object> selectAll() throws BaseManageServiceException {
        return selectAll(-1, -1);
    }

    *//**
     * 检查客户信息是否满足要求
     *
     * @param customer 客户信息实体
     * @return 返回是否满足要求
     *//*
    private boolean customerCheck(Customer customer) {
        return customer.getName() != null && customer.getPersonInCharge() != null && customer.getTel() != null
                && customer.getEmail() != null && customer.getAddress() != null;
    }

    *//**
     * 添加客户信息
     *
     * @param customer 客户信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     *//*
    @UserOperation(value = "添加客户信息")
    @Override
    public boolean addCustomer(Customer customer) throws BaseManageServiceException {

        // 插入新的记录
        if (customer != null) {
            // 验证
            if (customerCheck(customer)) {
                try {
                    if (null == warehouseMapper.selectByName(customer.getName())) {
                        warehouseMapper.insert(customer);
                        return true;
                    }
                } catch (PersistenceException e) {
                    throw new BaseManageServiceException(e);
                }
            }
        }
        return false;
    }

    *//**
     * 更新客户信息
     *
     * @param customer 客户信息
     * @return 返回一个boolean值，值为true代表更新成功，否则代表失败
     *//*
    @UserOperation(value = "修改客户信息")
    @Override
    public boolean updateCustomer(Customer customer) throws BaseManageServiceException {

        // 更新记录
        if (customer != null) {
            // 检验
            if (customerCheck(customer)) {
                try {
                    // 检查重名
                    Customer customerFromDB = warehouseMapper.selectByName(customer.getName());
                    if (customerFromDB == null || customerFromDB.getId().equals(customer.getId())) {
                        warehouseMapper.update(customer);
                        return true;
                    }
                } catch (PersistenceException e) {
                    throw new BaseManageServiceException(e);
                }
            }
        }
        return false;
    }


    *//**
     * 从文件中导入客户信息
     *
     * @param file 导入信息的文件
     * @return 返回一个Map，其中：key为total代表导入的总记录数，key为available代表有效导入的记录数
     *//*
    @UserOperation(value = "导入客户信息")
    @Override
    public Map<String, Object> importCustomer(MultipartFile file) throws BaseManageServiceException {
        // 初始化结果集
        Map<String, Object> result = new HashMap<>();
        int total = 0;
        int available = 0;

        // 从 Excel 文件中读取
        try {
            List<Customer> customers = ejConvertor.excelReader(Customer.class, FileUtil.convertMultipartFileToFile(file));
            if (customers != null) {
                total = customers.size();

                // 验证每一条记录
                List<Customer> availableList = new ArrayList<>();
                for (Customer customer : customers) {
                    if (customerCheck(customer)) {
                        if (warehouseMapper.selectByName(customer.getName()) == null)
                            availableList.add(customer);
                    }
                }

                // 保存到数据库
                available = availableList.size();
                if (available > 0) {
                    warehouseMapper.insertBatch(availableList);
                }
            }
        } catch (PersistenceException | IOException e) {
            throw new BaseManageServiceException(e);
        }

        result.put("total", total);
        result.put("available", available);
        return result;
    }

    *//**
     * 导出客户信息到文件中
     *
     * @param customers 包含若干条 customer 信息的 List
     * @return Excel 文件
     *//*
    @UserOperation(value = "导出客户信息")
    @Override
    public File exportCustomer(List<Customer> customers) {
        if (customers == null)
            return null;

        return ejConvertor.excelWriter(Customer.class, customers);
    }
*/
}
