package com.skipper.cms;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.skipper.cms.cms.shared.mapper")
public class SkipperCmsApplication {
    public static void main(String[] args) {
        SpringApplication.run(SkipperCmsApplication.class, args);
    }
}

