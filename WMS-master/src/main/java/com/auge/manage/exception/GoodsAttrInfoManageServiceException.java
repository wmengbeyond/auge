package com.auge.manage.exception;

/**
 * GoodsAttrInfoManageServiceException
 *
 * @author wm
 * @since 2018/2/26.
 */
public class GoodsAttrInfoManageServiceException extends BusinessException{

    public GoodsAttrInfoManageServiceException(){
        super();
    }

    public GoodsAttrInfoManageServiceException(Exception e, String exception){
        super(e, exception);
    }

    public GoodsAttrInfoManageServiceException(Exception e){
        super(e);
    }
}
