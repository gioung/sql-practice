-- 문제1.현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
	-- 평균연봉
    select avg(salary) from salaries;
    
    -- sol)
     select count(*) as '직원 수' from salaries  
     where to_date = '9999-01-01' 
     and salary>(select avg(salary) from salaries);

-- 문제2. 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
   
   -- 각 부서별로 최고의 급여를 받는 사원 
   -- sol)
   select d.dept_name,a.emp_no,concat(a.first_name,' ',a.last_name) as name,max(b.salary) as 최고연봉 
   from employees a,salaries b,dept_emp c,departments d 
   where a.emp_no = b.emp_no 
   and a.emp_no = c.emp_no 
   and c.dept_no = d.dept_no 
   and c.to_date = '9999-01-01' 
   and b.to_date = '9999-01-01' 
   group by d.dept_name 
   order by 최고연봉 desc;


-- 문제3.현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 

 -- sol)
select c.dept_name,d.emp_no,concat(d.first_name,' ',d.last_name) as name,a.salary,e.평균연봉 as 부서평균연봉  
 from salaries a,dept_emp b,departments c,employees d ,(select b.dept_no,avg(a.salary) as 평균연봉 
 from salaries a,dept_emp b,departments c 
 where a.emp_no = b.emp_no 
 and b.dept_no = c.dept_no 
 and b.to_date = '9999-01-01' 
 and a.to_date = '9999-01-01' 
 group by b.dept_no) e 
 where a.emp_no = b.emp_no 
 and b.dept_no = c.dept_no 
 and d.emp_no = a.emp_no 
 and d.emp_no = b.emp_no 
 and b.to_date = '9999-01-01' 
 and a.to_date = '9999-01-01' 
 and b.dept_no = e.dept_no 
 and a.salary > e.평균연봉;

 
 -- 부서 평균 급여 구하기
 select b.dept_no,avg(a.salary) as 평균연봉 
 from salaries a,dept_emp b,departments c 
 where a.emp_no = b.emp_no 
 and b.dept_no = c.dept_no 
 and b.to_date = '9999-01-01' 
 and a.to_date = '9999-01-01' 
 group by b.dept_no;

-- 문제4.현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
-- sol)
select c.dept_name,a.emp_no,concat(a.first_name,' ',a.last_name) as name,d.manager_name  
from employees a,dept_emp b,departments c,(select b.dept_name,concat(c.first_name,' ',c.last_name) as manager_name 
from dept_manager a , departments b , employees c 
 where a.emp_no = c.emp_no 
 and b.dept_no = a.dept_no 
 and a.to_date = '9999-01-01') d 
 where a.emp_no = b.emp_no 
 and b.dept_no = c.dept_no 
 and b.to_date = '9999-01-01' 
 and c.dept_name = d.dept_name;


 -- 매니저 이름과 부서이름 출력 테이블
 select b.dept_name,concat(c.first_name,' ',c.last_name) as name from dept_manager a , departments b , employees c 
 where a.emp_no = c.emp_no 
 and b.dept_no = a.dept_no 
 and a.to_date = '9999-01-01';

-- 문제5.현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

-- 현재 사원들의 사번 , 이름 , 직책 , 연봉 조회하기
select a.emp_no,concat(a.first_name,' ',a.last_name) as name,b.title,c.salary 
from employees a , titles b , salaries c , dept_emp d
where a.emp_no = b.emp_no 
and a.emp_no = c.emp_no 
and a.emp_no = d.emp_no 
and b.to_date = '9999-01-01' 
and c.to_date = '9999-01-01' 
and d.to_date = '9999-01-01';

-- 현재 평균연봉이 가장 높은 부서
select b.dept_no,(a.salary) as 평균연봉 from salaries a , dept_emp b 
where a.emp_no = b.emp_no 
and a.to_date='9999-01-01' 
and b.to_date='9999-01-01' 
group by b.dept_no 
order by 평균연봉 desc 
limit 0,1;

-- sol)
select a.emp_no,concat(a.first_name,' ',a.last_name) as name,b.title,c.salary 
from employees a , titles b , salaries c , dept_emp d , (select b.dept_no,(a.salary) as 평균연봉 
from salaries a , dept_emp b 
where a.emp_no = b.emp_no 
and a.to_date='9999-01-01' 
and b.to_date='9999-01-01' 
group by b.dept_no 
order by 평균연봉 desc
limit 0,1) e 
where a.emp_no = b.emp_no 
and a.emp_no = c.emp_no 
and a.emp_no = d.emp_no 
and b.to_date = '9999-01-01' 
and c.to_date = '9999-01-01' 
and d.to_date = '9999-01-01' 
and d.dept_no = e.dept_no 
order by c.salary desc;


-- 문제6.평균 연봉이 가장 높은 부서는? 
-- sol)
select b.dept_no,c.dept_name,(a.salary) as 평균연봉 from salaries a , dept_emp b ,departments c
where a.emp_no = b.emp_no 
and b.dept_no = c.dept_no 
and a.to_date='9999-01-01' 
and b.to_date='9999-01-01' 
group by b.dept_no 
order by 평균연봉 desc 
limit 0,1;


-- 문제7.평균 연봉이 가장 높은 직책?
select b.title,avg(a.salary) as 평균연봉 from salaries a , titles b 
where a.emp_no = b.emp_no 
and a.to_date = '9999-01-01' 
and b.to_date = '9999-01-01' 
group by b.title 
order by 평균연봉 desc 
limit 0,1; 


-- 문제8.현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은? 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

-- 부서이름 , 사원이름 , 연봉 
select c.dept_name,concat(a.first_name,' ',a.last_name) as name,d.salary from employees a , dept_emp b , departments c , salaries d 
where a.emp_no = b.emp_no 
and a.emp_no = d.emp_no 
and b.dept_no = c.dept_no 
and b.to_date = '9999-01-01' 
and d.to_date = '9999-01-01'; 

-- 매니저 이름 , 매니저 연봉 , 부서 이름
select c.dept_name,concat(a.first_name,' ',a.last_name) as name,d.salary from employees a , dept_manager b , departments c ,salaries d 
where a.emp_no = b.emp_no 
and b.dept_no = c.dept_no 
and a.emp_no = d.emp_no 
and b.to_date = '9999-01-01' 
and d.to_date = '9999-01-01';

-- sol)
select c.dept_name,concat(a.first_name,' ',a.last_name) as name,d.salary,e.manager_name,e.salary as manager_salary 
from employees a , dept_emp b , departments c , salaries d ,(select c.dept_name,concat(a.first_name,' ',a.last_name) as manager_name,d.salary 
from employees a , dept_manager b , departments c ,salaries d 
where a.emp_no = b.emp_no 
and b.dept_no = c.dept_no 
and a.emp_no = d.emp_no 
and b.to_date = '9999-01-01' 
and d.to_date = '9999-01-01') e 
where a.emp_no = b.emp_no 
and a.emp_no = d.emp_no 
and b.dept_no = c.dept_no 
and b.to_date = '9999-01-01' 
and d.to_date = '9999-01-01'
and d.salary>e.salary; 
























