package com.auge.manage.exception;

/**
 * BaseManageServiceException
 *
 * @author wm
 * @since 2018/2/7.
 */
public class BaseManageServiceException extends BusinessException{

    public BaseManageServiceException(){
        super();
    }

    public BaseManageServiceException(Exception e, String exception){
        super(e, exception);
    }

    public BaseManageServiceException(Exception e){
        super(e);
    }
}
