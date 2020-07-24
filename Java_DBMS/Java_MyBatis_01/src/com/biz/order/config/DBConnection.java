package com.biz.order.config;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
 * myabatis-context.xml 파일을 읽어서
 * 설정된 값으로 SqlSessionFactory를 만들게 된다.
 * DBMS에 SQL을 보내고, 받을때
 * 		SQL을 DBMS가 알수 있는 데이터로 변환하고
 * 		DBMS가 데이터(Table)를 보낼때
 * 		Java가 인식할수 있는 데이터로 변환하고
 * 
 * 		model 클래스(VO, DTO)에 데이터를 자동으로 추가해주는
 * 		기능을 수행한다.
 * 
 */

public class DBConnection {

	private static SqlSessionFactory sqlSessionFactory;
	private static String contextFile;
	
	static {
		
		contextFile = "com/biz/order/config/mybatis-context.xml";
		InputStream inputStream = null;
		
		try {

			// org.apache.ibatis.io.Resources
			// mybatis cofiguration 문서를 읽어서
			// xml로 설정된 항목들을 가져와서 mybatis에서 사용할 수 있는
			// 데이터 형태로 변환하여 inputStream에 저장해달라
			inputStream = Resources.getResourceAsStream(contextFile);
			
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			
			// SqlSessionFactoryBuilder의 build() method에 
			// Resources.get...(context)로 읽어 들인 inputStream 객체를
			// 매개변수로만 전달을 하면
			// sqSessionFactory를 만들어서 return 해준다.
			
			// sqlSessionFactory는 프로젝트가 시작될때 만들어져 
			// JVM이 관리하는 객체가된다.(static 이기 때문에)
			// 만약 이 프로젝트를 어떤경로로 2번이상 작동을 시킨다면
			// 작동되는 회수만큼 sqlSessionFactory가 계속해서 생성될 것이다.
			// sqlSessionFactory 객체는 하는일이 꽤 많아서 생성하는 것 자체만으로도
			// JVM입장에서는 부담이 될수 있다.
			// sqlSessionFactory를 생성하기 전에
			// 누군가 만들어서 사용중이라면 다시 만들지 않고 재활용을 할수 있도록
			// 해주는 것이 좋다.
			// if(sql.. == null) : 아직 아무도 sqlSessionFactory를 만들지 않았을때만
			// 생성하도록 조건을 부여하는 것이다.
			// 보통 이러한 객체는 private으로 선언하고, 생성에 조건을 부여하며
			// getter method를 통해서 외부에서 가져다 쓸수 있도록 한다.
			
			// *** 이러한 패턴을 싱글톤 패턴(SingleTone Pattern) 이라고 한다
			if(sqlSessionFactory == null) {
				sqlSessionFactory = builder.build(inputStream);	
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("SqlSessionFactory 생성중 xml 파일 문제 발생");
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}









