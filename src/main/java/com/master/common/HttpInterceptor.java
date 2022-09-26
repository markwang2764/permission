package com.master.common;

import com.master.util.JsonMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Slf4j
public class HttpInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURL().toString();
        Map parameterMap = request.getParameterMap();
        log.info("url:{}, params:{}", url, JsonMapper.obj2String(parameterMap));
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        String url = request.getRequestURL().toString();
        Map parameterMap = request.getParameterMap();
        log.info("request finished url:{}, params:{}", url, JsonMapper.obj2String(parameterMap));
        this.removeThreadLocalInfo();
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        String url = request.getRequestURL().toString();
        Map parameterMap = request.getParameterMap();
        log.info("request completion url:{}, params:{}", url, JsonMapper.obj2String(parameterMap));
        removeThreadLocalInfo();
    }

    public void removeThreadLocalInfo() {
        RequestHolder.remove();
    }
}
