package com.penske.CEM.config;

import core.config.BaseConfig;

public class ConfigCem extends BaseConfig {
    private static final String PRODUCT_PROPERTIES_FILE = "src/test/resources/product.properties";
    private static final ConfigCem instance = init();

    public ConfigCem() {
    }

    public static ConfigCem getInstance() {
        return instance;
    }

    private static ConfigCem init() {
        ConfigCem prodConfig = new ConfigCem();
        prodConfig.initProperties(PRODUCT_PROPERTIES_FILE);
        return prodConfig;
    }

    public final String PROJECT_NAME() {
        return this.getValuePipeline("project.name");
    }

    public final String APP_PASSWORD() {
        return this.getValuePipeline("password");
    }

    public final String DB_USERNAME() {
        return this.getValuePipeline("dbUserName");
    }

    public final String DB_PASSWORD() {
        return this.getValuePipeline("dbPassword");
    }

    public final String SSOID() {
        return this.getValuePipeline("SSOID");
    }

    public final String STANDARD_USER_SSOID() {
        return this.getValuePipeline("sso.standardUser.id");
    }

    public final String STANDARD_USER_PASSWORD() {
        return this.getValuePipeline("sso.standardUser.password");
    }

    public final String MANAGEMENT_USER_SSOID() {
        return this.getValuePipeline("sso.managementUser.id");
    }

    public final String MANAGEMENT_USER_PASSWORD() {
        return this.getValuePipeline("sso.managementUser.password");
    }
}