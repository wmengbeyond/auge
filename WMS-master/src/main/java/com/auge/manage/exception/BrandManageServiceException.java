package com.auge.manage.exception;

/**
 * BrandManageServiceException
 *
 * @author wm
 * @since 2018/2/26.
 */
public class BrandManageServiceException extends BusinessException{

    public BrandManageServiceException(){
        super();
    }

    public BrandManageServiceException(Exception e, String exception){
        super(e, exception);
    }

    public BrandManageServiceException(Exception e){
        super(e);
    }
}
