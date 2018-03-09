package com.auge.manage.common.controller;

import com.auge.manage.common.service.Interface.GoodsAttrInfoManageService;
import com.auge.manage.common.util.Response;
import com.auge.manage.common.util.ResponseFactory;
import com.auge.manage.domain.GoodsAttrInfo;
import com.auge.manage.exception.GoodsAttrInfoManageServiceException;
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
@RequestMapping(value = "/**/goodsAttrInfoManage")
@Controller
public class GoodsAttrInfoManageHandler {

    @Autowired
    private GoodsAttrInfoManageService goodsAttrInfoManageService;

    private static final String SEARCH_BY_NAME = "searchByName";
    private static final String SEARCH_ALL = "searchAll";

    /**
     * 通用的结果查询方法
     *
     * @param keyWord    查询关键字
     * @return 返回指定条件查询的结果
     */
    private Map<String, Object> query(String keyWord) throws GoodsAttrInfoManageServiceException {
        Map<String, Object> queryResult = null;

        queryResult = goodsAttrInfoManageService.selectGoodsAttrInfo(keyWord);

        return queryResult;
    }

    /** 搜索商品信息
     *
     * @param keyWord    搜索的关键字
     * @return 返回查询的结果，其中键值为 rows 的代表查询到的每一记录，若有分页则为分页大小的记录；键值为 total 代表查询到的符合要求的记录总条数
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "getGoodsAttrInfos", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getGoodsAttrInfoList(@RequestParam("keyWord") String keyWord) throws GoodsAttrInfoManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        List<GoodsAttrInfo> rows = null;
        long total = 0;

        Map<String, Object> queryResult = query(keyWord);

        if (queryResult != null) {
            rows = (List<GoodsAttrInfo>) queryResult.get("data");
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
    private Map<String, Object> query(String keyWord, int offset, int limit) throws GoodsAttrInfoManageServiceException {
        Map<String, Object> queryResult = null;

        if (!keyWord.isEmpty()) {

            queryResult = goodsAttrInfoManageService.selectByName(offset, limit, keyWord);

        } else {

            queryResult = goodsAttrInfoManageService.selectAll(offset, limit);
        }
        return queryResult;
    }

    /**
     * 搜索商品信息
     *
     * @param offset     如有多条记录时分页的偏移值
     * @param limit      如有多条记录时分页的大小
     * @param keyWord    搜索的关键字
     * @return 返回查询的结果，其中键值为 rows 的代表查询到的每一记录，若有分页则为分页大小的记录；键值为 total 代表查询到的符合要求的记录总条数
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "getGoodsAttrInfoList", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getGoodsAttrInfoList(@RequestParam("offset") int offset,
                                        @RequestParam("limit") int limit,
                                        @RequestParam("keyWord") String keyWord) throws GoodsAttrInfoManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        List<GoodsAttrInfo> rows = null;
        long total = 0;

        Map<String, Object> queryResult = query(keyWord, offset, limit);

        if (queryResult != null) {
            rows = (List<GoodsAttrInfo>) queryResult.get("data");
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
     * @param goodsAttrInfo 品牌信息
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与 error
     */
    @RequestMapping(value = "addGoodsAttrInfo", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addGoodsAttrInfo(@RequestBody GoodsAttrInfo goodsAttrInfo) throws GoodsAttrInfoManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        // 添加记录
        String result = goodsAttrInfoManageService.addGoodsAttrInfo(goodsAttrInfo) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

   /* *
     * 查询指定 customer ID 商品的信息
     *
     * @param customerID 商品ID
     * @return 返回一个map，其中：key 为 result 的值为操作的结果，包括：success 与 error；key 为 data
     * 的值为商品信息

    @RequestMapping(value = "getCustomerInfo", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getCustomerInfo(@RequestParam("customerID") String customerID) throws CustomerManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();
        String result = Response.RESPONSE_RESULT_ERROR;

        // 获取商品信息
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
     * @param goodsAttrInfo 商品信息
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与 error
     */
    @RequestMapping(value = "updateGoodsAttrInfo", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateCustomer(@RequestBody GoodsAttrInfo goodsAttrInfo) throws GoodsAttrInfoManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        // 更新
        String result = goodsAttrInfoManageService.updateGoodsAttrInfo(goodsAttrInfo) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    /**
     * 删除商品记录
     *
     * @param idStr 商品ID
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与 error
     */
    @RequestMapping(value = "deleteGoodsAttrInfo", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> deleteGoodsAttrInfo(@RequestParam("ID") String idStr) throws GoodsAttrInfoManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();

        // 参数检查
        if (StringUtils.isNumeric(idStr)) {
            // 转换为 Integer
            Integer goodsAttrInfoID = Integer.valueOf(idStr);

            // 刪除
            String result = goodsAttrInfoManageService.deleteGoodsAttrInfo(goodsAttrInfoID) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;
            responseContent.setResponseResult(result);
        } else
            responseContent.setResponseResult(Response.RESPONSE_RESULT_ERROR);

        return responseContent.generateResponse();
    }

    /**
     * 导入品牌信息
     *
     * @param file 保存有商品信息的文件
     * @return 返回一个map，其中：key 为 result表示操作的结果，包括：success 与
     * error；key为total表示导入的总条数；key为available表示有效的条数
     */
    @RequestMapping(value = "importGoodsAttrInfo", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> importCustomer(@RequestParam("file") MultipartFile file) throws GoodsAttrInfoManageServiceException {
        // 初始化 Response
        Response responseContent = ResponseFactory.newInstance();
        String result = Response.RESPONSE_RESULT_SUCCESS;

        // 读取文件内容
        int total = 0;
        int available = 0;
        if (file == null)
            result = Response.RESPONSE_RESULT_ERROR;
        Map<String, Object> importInfo = goodsAttrInfoManageService.importGoodsAttrInfo(file);
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
    @RequestMapping(value = "exportGoodsAttrInfo", method = RequestMethod.GET)
    public void exportCustomer(@RequestParam("searchType") String searchType, @RequestParam("keyWord") String keyWord,
                               HttpServletResponse response) throws GoodsAttrInfoManageServiceException, IOException {

        String fileName = "goodsAttrInfoInfo.xlsx";

        List<GoodsAttrInfo> goodsAttrInfos = null;
        Map<String, Object> queryResult = query(keyWord, -1, -1);

        if (queryResult != null) {
            goodsAttrInfos = (List<GoodsAttrInfo>) queryResult.get("data");
        }

        // 获取生成的文件
        File file = goodsAttrInfoManageService.exportGoodsAttrInfo(goodsAttrInfos);

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
