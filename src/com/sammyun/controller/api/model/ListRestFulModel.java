package com.sammyun.controller.api.model;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSeeAlso;

import com.sammyun.entity.app.AppClientVersion;

@XmlRootElement(name = "attendanceRestFulModel")
@XmlSeeAlso({
        AppClientVersion.class
})
public class ListRestFulModel
{
    /** 错误编码 */
    private Integer resultCode;

    /** 错误信息 */
    private String resultMessage;

    private List<?> rows;

    /** 分页信息 */
    private PageModel page;

    @XmlElement
    public Integer getResultCode()
    {
        return resultCode;
    }

    public void setResultCode(Integer resultCode)
    {
        this.resultCode = resultCode;
    }

    @XmlElement
    public String getResultMessage()
    {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage)
    {
        this.resultMessage = resultMessage;
    }

    @XmlElement
    public List<?> getRows()
    {
        return rows;
    }

    public void setRows(List<?> rows)
    {
        this.rows = rows;
    }

    @XmlElement
    public PageModel getPage()
    {
        return page;
    }

    public void setPage(PageModel page)
    {
        this.page = page;
    }

}
