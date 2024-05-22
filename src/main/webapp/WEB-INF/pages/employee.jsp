
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<html>
<head>
    <title>Employee Page</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1, h3 {
            color: #333;
        }

        .empTable {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .empTable th, .empTable td {
            text-align: left;
            padding: 12px;
            border: 1px solid #ddd;
        }

        .empTable th {
            background-color: #4CAF50;
            color: white;
        }

        .empTable tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .empTable tr:hover {
            background-color: #ddd;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            margin: 20px 0;
        }

        form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        form input[type="text"], form input[type="number"], form input[type="email"],
        form input[type="submit"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>

    <c:if test="${empty employee.employeeId}">
        <h1>
            <spring:message code="AddEmployee" />
        </h1>
    </c:if>

    <c:url var="addAction" value="/employee/add"></c:url>

    <form:form action="${addAction}" modelAttribute="employee" id="employeeForm">
        <table>
            <c:if test="${not empty employee.employeeId}">
                <h1>
                    <spring:message code="EditEmployee" />
                </h1>
                <tr>
                    <td><form:label path="employeeId">
                            <spring:message code="EmployeeID" />
                        </form:label></td>
                    <td><form:input path="employeeId" readonly="true" size="8"
                            disabled="true" /> <form:hidden path="employeeId" /></td>
                </tr>
            </c:if>

            <tr>
                <td><form:label path="firstName">
                        <spring:message code="FirstName" />
                    </form:label></td>
                <td><form:input path="firstName" /></td>
            </tr>

            <tr>
                <td><form:label path="lastName">
                        <spring:message code="LastName" />
                    </form:label></td>
                <td><form:input path="lastName" /></td>
            </tr>

            <tr>
                <td><form:label path="age">
                        <spring:message code="Age" />
                    </form:label></td>
                <td><form:input path="age" /></td>
            </tr>

            <tr>
                <td><form:label path="education">
                        <spring:message code="Education" />
                    </form:label></td>
                <td><form:input path="education" /></td>
            </tr>

            <tr>
                <td><form:label path="salary">
                        <spring:message code="Salary" />
                    </form:label></td>
                <td><form:input path="salary" /></td>
            </tr>

            <tr>
                <td colspan="2"><input type="submit"
                    value="<spring:message code='Submit' />" /></td>
            </tr>

        </table>
    </form:form>
    <br>

    <c:if test="${not empty employeeList}">
        <h3>
            <spring:message code="employeeList" />
        </h3>
        <table class="empTable">
            <tr>
                <th width="80">ID</th>
                <th width="120">First Name</th>
                <th width="120">Last Name</th>
                <th width="120">Age</th>
                <th width="120">Education</th>
                <th width="120">Salary</th>
                <th width="60">Edit</th>
                <th width="60">Delete</th>
            </tr>

            <c:forEach items="${employeeList}" var="employee">
                <tr>
                    <td>${employee.employeeId}</td>
                    <td>${employee.firstName}</td>
                    <td>${employee.lastName}</td>
                    <td>${employee.age}</td>
                    <td>${employee.education}</td>
                    <td>${employee.salary}</td>
                    <td><a href="<c:url value='/employee/edit/${employee.employeeId}' />">Edit</a></td>
                    <td><a href="<c:url value='/employee/remove/${employee.employeeId}' />" class="delete-link">Delete</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <script>
        document.getElementById('employeeForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const form = this;
            Swal.fire({
                title: 'Are you sure?',
                text: "You want to submit this form!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, submit it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                    Swal.fire(
                        'Submitted!',
                        'Your form has been submitted.',
                        'success'
                    )
                }
            })
        });

        document.querySelectorAll('.delete-link').forEach(function(element) {
            element.addEventListener('click', function(event) {
                event.preventDefault();
                const url = this.href;
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = url;
                        Swal.fire(
                            'Deleted!',
                            'The record has been deleted.',
                            'success'
                        )
                    }
                })
            });
        });
    </script>
</body>
</html>
apps-fileview.texmex_20240502.01_p3
Employee.txt
Displaying Employee.txt.