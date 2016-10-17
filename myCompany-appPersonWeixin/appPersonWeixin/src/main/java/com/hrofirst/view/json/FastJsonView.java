package com.hrofirst.view.json;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.support.spring.FastJsonJsonView;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

/**
 * Created by qixb.fnst on 2014/10/17.
 */
public class FastJsonView extends FastJsonJsonView {

    private boolean updateContentLength = false;
    private HibernateJsonFilter hibernateJsonFilter = new HibernateJsonFilter();

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
                                           HttpServletResponse response) throws Exception {
        Object value = filterModel(model);

        String text = JSON.toJSONString(value, hibernateJsonFilter, getFeatures());
        byte[] bytes = text.getBytes(getCharset());

        OutputStream stream = this.updateContentLength ? createTemporaryOutputStream() : response.getOutputStream();
        stream.write(bytes);

        if (this.updateContentLength) {
            writeToResponse(response, (ByteArrayOutputStream) stream);
        }
    }

    /**
     * Whether to update the 'Content-Length' header of the response. When set to {@code true}, the response is buffered
     * in order to determine the content length and set the 'Content-Length' header of the response.
     * <p/>
     * The default setting is {@code false}.
     */
    public void setUpdateContentLength(boolean updateContentLength) {
        this.updateContentLength = updateContentLength;
    }

    public static ModelAndView Render(Object model, HttpServletResponse response) {
        String text = JSON.toJSONString(model);
        byte[] bytes = text.getBytes(FastJsonJsonView.UTF8);
        OutputStream stream = null;
        try {
            stream = response.getOutputStream();
            stream.write(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

}
