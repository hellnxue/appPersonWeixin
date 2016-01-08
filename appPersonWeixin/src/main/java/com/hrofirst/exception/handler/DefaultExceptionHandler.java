/**
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.hrofirst.exception.handler;

import com.fnst.es.common.utils.LogUtils;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * <p>Date: 13-5-7 下午3:38
 * <p>Version: 1.0
 */
@ControllerAdvice
public class DefaultExceptionHandler {

    /**
     * 没有权限 异常
     * <p/>
     * 后续根据不同的需求定制即可
     */
    @ExceptionHandler({UnauthorizedException.class})
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ModelAndView processUnauthenticatedException(NativeWebRequest request, UnauthorizedException e) {
        LogUtils.logError("用户权限验证失败", e);
        ExceptionResponse exceptionResponse = ExceptionResponse.from(e);

        ModelAndView mv = new ModelAndView();
        mv.addObject("error", exceptionResponse);
        mv.setViewName("error/exception");

        return mv;
    }


    /**
     * handle for  Exception
     */
    @ExceptionHandler({Exception.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView processException(HttpServletRequest request, Exception e, HttpServletResponse response) throws IOException {
        //TODO
        return new ModelAndView();
    }


}
