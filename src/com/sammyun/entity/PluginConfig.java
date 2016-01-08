/*
 * Copyright 2012-2014 sammyun.com.cn. All rights reserved.
 * Support: http://www.sammyun.com.cn
 * License: http://www.sammyun.com.cn/license
 */
package com.sammyun.entity;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.MapKeyColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Entity - 插件配置
 * 
 * @author Sencloud Team
 * @version 3.0
 */
@Entity
@Table(name = "t_pe_plugin_config")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "t_pe_plugin_config_sequence")
public class PluginConfig extends OrderEntity
{

    private static final long serialVersionUID = -4357367409438384806L;

    // 支付宝的公钥，无需修改该值
    public static String ALI_PUBLIC_KEY = "";

    public static String ALI_PRIVATE_KEY = "";

    public static String INPUT_CHARSET = "utf-8";

    // 签名方式，选择项：0001(RSA)、MD5
    public static String SIGN_TYPE = "MD5";

    /** 插件ID */
    private String pluginId;

    /** 是否启用 */
    private Boolean isEnabled;

    /** 属性 */
    private Map<String, String> attributes = new HashMap<String, String>();

    /**
     * 获取插件ID
     * 
     * @return 插件ID
     */
    @Column(nullable = false, updatable = false, unique = true, length = 100)
    public String getPluginId()
    {
        return pluginId;
    }

    /**
     * 设置插件ID
     * 
     * @param pluginId 插件ID
     */
    public void setPluginId(String pluginId)
    {
        this.pluginId = pluginId;
    }

    /**
     * 获取是否启用
     * 
     * @return 是否启用
     */
    @Column(nullable = false)
    public Boolean getIsEnabled()
    {
        return isEnabled;
    }

    /**
     * 设置是否启用
     * 
     * @param isEnabled 是否启用
     */
    public void setIsEnabled(Boolean isEnabled)
    {
        this.isEnabled = isEnabled;
    }

    /**
     * 获取属性
     * 
     * @return 属性
     */
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "T_PE_plugin_config_attribute")
    @MapKeyColumn(name = "name", length = 100)
    public Map<String, String> getAttributes()
    {
        return attributes;
    }

    /**
     * 设置属性
     * 
     * @param attributes 属性
     */
    public void setAttributes(Map<String, String> attributes)
    {
        this.attributes = attributes;
    }

    /**
     * 获取属性值
     * 
     * @param name 属性名称
     * @return 属性值
     */
    @Transient
    public String getAttribute(String name)
    {
        if (getAttributes() != null && name != null)
        {
            return getAttributes().get(name);
        }
        else
        {
            return null;
        }
    }

    /**
     * 设置属性值
     * 
     * @param name 属性名称
     * @param value 属性值
     */
    @Transient
    public void setAttribute(String name, String value)
    {
        if (getAttributes() != null && name != null)
        {
            getAttributes().put(name, value);
        }
    }

}