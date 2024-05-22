package com.aa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aa.dao.EmployeeDao;
import com.aa.model.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDao employeeDao;
	
	@Override
	@Transactional
	public void addEmployee(Employee employee) {

		System.out.println("EmployeeServiceImpl add employee method");

		employeeDao.addEmployee(employee);
	}

	@Transactional
	public void updateEmployee(Employee employee) {

		employeeDao.updateEmployee(employee);
	}

	//@Override
	@Transactional
	public Employee getEmployeeById(int id) {

		return employeeDao.getEmployeeById(id);
	}

	//@Override
	@Transactional
	public void removeEmployee(int id) {

		employeeDao.removeEmployee(id);
	}

	//@Override
	@Transactional
	public List<Employee> listEmployees() {
		

		return this.employeeDao.listEmployees();
	}
	

}
