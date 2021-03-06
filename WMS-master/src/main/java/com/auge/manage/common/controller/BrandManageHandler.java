package com.auge.manage.common.controller;

import com.auge.manage.common.service.Interface.BrandManageService;
import com.auge.manage.common.util.Response;
import com.auge.manage.common.util.ResponseFactory;
import com.auge.manage.domain.Brand;
import com.auge.manage.exception.BrandManageServiceException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * 基础信息管理请求 Handler
 *
 * @author wm
 */
@RequestMapping(value = "/**/brandManage")
@Controller
public class BrandManageHandler {

    @Autowired
    private BrandManageService brandManageService;

    private static final String SEARCH_BY_NAME = "searchByName";
    private static final String SEARCH_ALL = "searchAll";

    /**
     * 通用的结果查询方法
     *
     * @param keyWord    查询关键字
     * @return 返回指定条件查询的结果
     */
    private Map<String, Object> query(String keyWord) throws BrandManageServiceException {
        Map<String, Object> queryResult = null;

        queryResult = brandManageService.selectBrand(keyWord);

        return queryResult;
    }

    /** 搜索客户信息
     *
     * @param keyWord    搜索的关键字
     * @return 返回查询的结果，其中键值为 rows 的代表查询到的每一记录，若有分页则为分页大小的记录；键值为 total 代表查询到的符合要求的记录总条数
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "getBrands", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getBrandList(@RequestParam("keyWord") String keyWord) throws BrandManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        List<Brand> rows = null;
        long total = 0;

        Map<String, Object> queryResult = query(keyWord);

        if (queryResult != null) {
            rows = (List<Brand>) queryResult.get("data");
            Object obj = queryResult.get("total");
            if (obj instanceof Integer) {
                total = Long.parseLong(obj.toString());
            }
        }

        // 设置 Response
        responseContent.setCustomerInfo("rows", rows);
        responseContent.setResponseTotal(total);
        responseContent.setResponseResult(Response.RESPONSE_RESULT_SUCCESS);
        return responseContent.generateResponse();
    }

    /**
     * 通用的结果查询方法
     *
     * @param keyWord    查询关键字
     * @param offset     分页偏移值
     * @param limit      分页大小
     * @return 返回指定条件查询的结果
     */
    private Map<String, Object> query(String keyWord, int offset, int limit) throws BrandManageServiceException {
        Map<String, Object> queryResult = null;

        if (!keyWord.isEmpty()) {

            queryResult = brandManageService.selectByName(offset, limit, keyWord);

        } else {

            queryResult = brandManageService.selectAll(offset, limit);
        }
        return queryResult;
    }

    /**
     * 搜索客户信息
     *
     * @param offset     如有多条记录时分页的偏移值
     * @param limit      如有多条记录时分页的大小
     * @param keyWord    搜索的关键字
     * @return 返回查询的结果，其中键值为 rows 的代表查询到的每一记录，若有分页则为分页大小的记录；键值为 total 代表查询到的符合要求的记录总条数
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "getBrandList", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getBrandList(@RequestParam("offset") int offset,
                                        @RequestParam("limit") int limit,
                                        @RequestParam("keyWord") String keyWord) throws BrandManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        List<Brand> rows = null;
        long total = 0;

        Map<String, Object> queryResult = query(keyWord, offset, limit);

        if (queryResult != null) {
            rows = (List<Brand>) queryResult.get("data");
            total = (long) queryResult.get("total");
        }

        // 设置 Response
        responseContent.setCustomerInfo("rows", rows);
        responseContent.setResponseTotal(total);
        responseContent.setResponseResult(Response.RESPONSE_RESULT_SUCCESS);
        return responseContent.generateResponse();
    }

    /**
     * 添加一条商品品牌信息
     *
     * @param brand 品牌信息
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与 error
     */
    @RequestMapping(value = "addBrand", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addBrand(@RequestBody Brand brand) throws BrandManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        // 添加记录
        String result = brandManageService.addBrand(brand) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

   /* *
     * 查询指定 customer ID 客户的信息
     *
     * @param customerID 客户ID
     * @return 返回一个map，其中：key 为 result 的值为操作的结果，包括：success 与 error；key 为 data
     * 的值为客户信息

    @RequestMapping(value = "getCustomerInfo", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getCustomerInfo(@RequestParam("customerID") String customerID) throws CustomerManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();
        String result = Response.RESPONSE_RESULT_ERROR;

        // 获取客户信息
        Customer customer = null;
        Map<String, Object> queryResult = query(SEARCH_BY_ID, customerID, -1, -1);
        if (queryResult != null) {
            customer = (Customer) queryResult.get("data");
            if (customer != null) {
                result = Response.RESPONSE_RESULT_SUCCESS;
            }
        }

        // 设置 Response
        responseContent.setResponseResult(result);
        responseContent.setResponseData(customer);

        return responseContent.generateResponse();
    }*/

    /**
     * 更新品牌信息
     *
     * @param brand 客户信息
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与 error
     */
    @RequestMapping(value = "updateBrand", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateCustomer(@RequestBody Brand brand) throws BrandManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        // 更新
        String result = brandManageService.updateBrand(brand) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    /**
     * 删除客户记录
     *
     * @param idStr 品牌ID
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与 error
     */
    @RequestMapping(value = "deleteBrand", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> deleteBrand(@RequestParam("ID") String idStr) throws BrandManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        // 参数检查
        if (StringUtils.isNumeric(idStr)) {
            // 转换为 Integer
            Integer brandID = Integer.valueOf(idStr);

            // 刪除
            String result = brandManageService.deleteBrand(brandID) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;
            responseContent.setResponseResult(result);
        } else
            responseContent.setResponseResult(Response.RESPONSE_RESULT_ERROR);

        return responseContent.generateResponse();
    }

    /**
     * 导入品牌信息
     *
     * @param file 保存有客户信息的文件
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与
     * error；key为total表示导入的总条数；key为available表示有效的条数
     */
    @RequestMapping(value = "importBrand", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> importCustomer(@RequestParam("file") MultipartFile file) throws BrandManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();
        String result = Response.RESPONSE_RESULT_SUCCESS;

        // 读取文件内容
        int total = 0;
        int available = 0;
        if (file == null)
            result = Response.RESPONSE_RESULT_ERROR;
        Map<String, Object> importInfo = brandManageService.importBrand(file);
        if (importInfo != null) {
            total = (int) importInfo.get("total");
            available = (int) importInfo.get("available");
        }

        responseContent.setResponseResult(result);
        responseContent.setResponseTotal(total);
        responseContent.setCustomerInfo("available", available);
        return responseContent.generateResponse();
    }

    /**
     * 导出品牌信息
     *
     * @param searchType 查找类型
     * @param keyWord    查找关键字
     * @param response   HttpServletResponse
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "exportBrand", method = RequestMethod.GET)
    public void exportCustomer(@RequestParam("searchType") String searchType, @RequestParam("keyWord") String keyWord,
                               HttpServletResponse response) throws BrandManageServiceException, IOException {

        String fileName = "brandInfo.xlsx";

        List<Brand> brands = null;
        Map<String, Object> queryResult = query(keyWord, -1, -1);

        if (queryResult != null) {
            brands = (List<Brand>) queryResult.get("data");
        }

        // 获取生成的文件
        File file = brandManageService.exportBrand(brands);

        // 写出文件
        if (file != null) {
            // 设置响应头
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
            FileInputStream inputStream = new FileInputStream(file);
            OutputStream outputStream = response.getOutputStream();
            byte[] buffer = new byte[8192];

            int len;
            while ((len = inputStream.read(buffer, 0, buffer.length)) > 0) {
                outputStream.write(buffer, 0, len);
                outputStream.flush();
            }

            inputStream.close();
            outputStream.close();

        }
    }
}
