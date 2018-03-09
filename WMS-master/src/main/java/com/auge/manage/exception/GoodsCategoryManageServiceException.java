package com.auge.manage.exception;

/**
 * GoodsCategoryManageServiceException
 *
 * @author wm
 * @since 2018/2/26.
 */
public class GoodsCategoryManageServiceException extends BusinessException{

    public GoodsCategoryManageServiceException(){
        super();
    }

    public GoodsCategoryManageServiceException(Exception e, String exception){
        super(e, exception);
    }

    public GoodsCategoryManageServiceException(Exception e){
        super(e);
    }
}
