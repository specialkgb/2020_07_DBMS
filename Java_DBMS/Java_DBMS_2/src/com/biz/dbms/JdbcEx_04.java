package com.biz.dbms;

import com.biz.dbms.service.OrderInput;
import com.biz.dbms.service.OrderService;
import com.biz.dbms.service.OrderServiceImplV1;

public class JdbcEx_04 {

	public static void main(String[] args) {

		OrderService oService = new OrderServiceImplV1();
		OrderInput oInput = new OrderInput();

		while (true) {
			// 수정사항 입력받고 데이터 Update
			if (!oInput.orderUpdate()) {
				break;
			}
		}
		System.out.println("업무종료!");
	}
}