package com.demo.Spring_Core;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("com/demo/Spring_Core/bean.xml");
		Employee emp = context.getBean("employee", Employee.class);
		System.out.println(emp);
	}
}
