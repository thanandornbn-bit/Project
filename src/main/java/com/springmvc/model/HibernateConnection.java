package com.springmvc.model;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class HibernateConnection {
	public static SessionFactory sessionFactory = null;;

	static String url;
	static String uname;
	static String pwd;

	static {
		// Check if running in Docker environment
		String dockerProfile = System.getProperty("spring.profiles.active");
		if ("docker".equals(dockerProfile)) {
			// Docker environment - connect to mysql container
			url = "jdbc:mysql://mysql:3306/thanachok03?characterEncoding=UTF-8";
			uname = "root";
			pwd = "1234";
		} else {
			// Local development environment
			url = "jdbc:mysql://localhost:3306/thanachok03?characterEncoding=UTF-8";
			uname = "root";
			pwd = "1234";
		}
	}

	public static SessionFactory doHibernateConnection() {
		// Return existing SessionFactory if already created
		if (sessionFactory != null && !sessionFactory.isClosed()) {
			return sessionFactory;
		}

		// Create SessionFactory once (thread-safe lazy init)
		synchronized (HibernateConnection.class) {
			if (sessionFactory == null || sessionFactory.isClosed()) {
				Properties database = new Properties();
				// After initial schema creation remove or change in production
				database.setProperty("hibernate.hbm2ddl.auto", "update");
				// Use modern MySQL driver class
				database.setProperty("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
				database.setProperty("hibernate.connection.username", uname);
				database.setProperty("hibernate.connection.password", pwd);
				database.setProperty("hibernate.connection.url", url);

				// Basic connection pool limit (legacy built-in pool). For production, use
				// HikariCP or a DataSource.
				database.setProperty("hibernate.connection.pool_size", "10");

				database.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL5InnoDBDialect");
				Configuration cfg = new Configuration().setProperties(database).addPackage("com.springmvc.model")
						.addAnnotatedClass(Invoice.class)
						.addAnnotatedClass(InvoiceDetail.class)
						.addAnnotatedClass(InvoiceType.class)
						.addAnnotatedClass(Manager.class)
						.addAnnotatedClass(Member.class)
						.addAnnotatedClass(Reserve.class)
						.addAnnotatedClass(Rent.class)
						.addAnnotatedClass(Room.class);

				StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
				sessionFactory = cfg.buildSessionFactory(ssrb.build());
			}
			return sessionFactory;
		}
	}
}