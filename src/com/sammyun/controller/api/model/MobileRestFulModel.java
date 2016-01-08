package com.sammyun.controller.api.model;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSeeAlso;

@XmlRootElement(name = "loginRestFulModel")
@XmlSeeAlso({})
public class MobileRestFulModel
{
    /** 错误编码 */
    private Integer resultCode;

    /** 错误信息 */
    private String resultMessage;

    /** 返回数据 */
    private Object rows;

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
    public Object getRows()
    {
        return rows;
    }

    public void setRows(Object rows)
    {
        this.rows = rows;
    }

}
