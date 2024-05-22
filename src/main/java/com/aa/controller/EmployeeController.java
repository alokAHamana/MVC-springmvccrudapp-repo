package com.aa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aa.model.Employee;
import com.aa.service.EmployeeService;

@Controller
public class EmployeeController { //oooooooooooooooooo
	
	@Autowired
	private EmployeeService employeeService;   // jo bhi class is class ko implement kr rhi hogi uska object bana kr is employeeService mein inject kr degi
	
	
	@RequestMapping(value="/employees" , method= RequestMethod.GET)
	public String listemployee(Model model) {
		

		
		System.out.println("request at controller and add data to list of ALOK");
		
		model.addAttribute("employee" , new Employee());
		model.addAttribute("employeeList", employeeService.listEmployees());
		
		

		return "employee" ;
		
		
	}
		
		 // Same method For both Add and Update Employee
	   
	@RequestMapping(value = "/employee/add", method = RequestMethod.POST)
	    public String addEmployee(@ModelAttribute("employee") Employee employee) {
	 
	        if (employee.getEmployeeId()==null || employee.getEmployeeId() == 0) {
	            // new employee, add it
	            employeeService.addEmployee(employee);
	        	System.out.println("new employee record added");
	        	System.out.println(employee);
	        	
	        } else {
	            // existing employee, call update
	            employeeService.updateEmployee(employee);
	        	System.out.println("existing employee updated");
	        }
	 
	        return "redirect:/employees";
	        
	}
	        
	        @RequestMapping("/employee/remove/{id}")
	        public String removeemployee(@PathVariable("id") int id) {
	     
	            employeeService.removeEmployee(id);
	            return "redirect:/employees";
	        }
	     
	        @RequestMapping("/employee/edit/{id}")
	        public String editemployee(@PathVariable("id") int id, Model model) {
	            model.addAttribute("employee", employeeService.getEmployeeById(id));
	            model.addAttribute("employeeList", employeeService.listEmployees());
	            return "employee";
		
		
	        }
	}