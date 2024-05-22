package com.aa.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.aa.model.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao{

	
	  @Autowired 
	  private SessionFactory sessionFactory;
	 
	@Override
	public void addEmployee(Employee employee) {

		System.out.println(" dao method added");
		
		  Session session = sessionFactory.getCurrentSession();
		  
		  session.persist(employee);
		 
		}
	

	@Override
	public void updateEmployee(Employee employee) {

		 Session session = sessionFactory.getCurrentSession();
		  
		  session.update(employee);
	}

	@Override
	public Employee getEmployeeById(int id) {

		 Session session = sessionFactory.getCurrentSession();      
	        Employee employee = (Employee) session.get(Employee.class, new Integer(id));
	        return employee;

	}

	@Override
	public void removeEmployee(int id) {

		Session session = sessionFactory.getCurrentSession();
        Employee employee = (Employee) session.get(Employee.class, new Integer(id));
        if(null != employee){
            session.delete(employee);
        }
	}

	@Override
	public List<Employee> listEmployees() {
	
		Session session = sessionFactory.getCurrentSession();
	        List<Employee> EmployeesList = session.createQuery("from Employee").list();
	        return EmployeesList;
	    
	}

}
