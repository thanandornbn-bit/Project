package com.springmvc.config;

import org.springframework.lang.NonNull;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
import jakarta.servlet.Filter;
import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletRegistration;

public class SpringMVCDispatcherServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[0];
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] { WebConfig.class };
	}

	@Override
	@NonNull
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	@Override
	protected jakarta.servlet.Filter[] getServletFilters() {
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		return new Filter[] { characterEncodingFilter };
	}

	// ✅ เพิ่มส่วนนี้
	@Override
	protected void customizeRegistration(@NonNull ServletRegistration.Dynamic registration) {
		// location, maxFileSize, maxRequestSize, fileSizeThreshold
		MultipartConfigElement multipartConfigElement = new MultipartConfigElement(null, 20971520, 41943040, 0);
		registration.setMultipartConfig(multipartConfigElement);
	}
}
