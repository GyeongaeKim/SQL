--문제1. 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
--(56건)
select avg(salary) from employees; --평균급여

select first_name,
       salary
from employees
where salary<(select avg(salary)
                 from employees)
order by salary desc;



--문제2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의
--직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를
--급여의 오름차순으로 정렬하여 출력하세요
--(51건)
select avg(salary) from employees; --평균급여6461.83...
select max(salary) from employees; --최대급여24000
select avg(salary) avgSalary, max(salary) maxSalary from employees;

select employee_id 직원번호,
       first_name 이름,
       salary 급여
from employees 
where salary>=(select avg(salary) from employees)
    and salary<=(select max(salary) from employees)
order by salary asc;

select employee_id 직원번호,
       first_name 이름,
       salary 급여,
       round(avgSalary) 평균급여,
       maxSalary 최대급여
from employees e, (select avg(salary) avgSalary, max(salary) maxSalary 
                   from employees) ma
where e.salary>=ma.avgSalary
      and e.salary<=ma.maxSalary
order by salary asc;



--문제3.직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가
--있는 곳의 주소를 알아보려고 한다.
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city),
--주(state_province), 나라아이디(country_id) 를 출력하세요
--(1건)
select department_id from employees
where first_name='Steven' and last_name='King';

select lo.location_id,
       lo.street_address,
       lo.postal_code,
       lo.city,
       lo.state_province,
       lo.country_id
from locations lo, departments de
where lo.location_id=de.location_id
    and department_id in (select department_id from employees
                          where first_name='Steven' and last_name='King');




--문제4.job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의
--사번,이름,급여를 급여의 내림차순으로 출력하세요 -ANY연산자 사용
--(74건)
select salary from employees 
where job_id='ST_MAN'; --8000/8200/7900/6500/5800

select employee_id,
       first_name,
       salary
from employees
where salary<any(select salary
                 from employees 
                 where job_id='ST_MAN')
order by salary desc;




--문제5.각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과
--급여(salary) 부서번호(department_id)를 조회하세요
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
--조건절비교, 테이블조인 2가지 방법으로 작성하세요
--(11건)
--1)조건절비교
select department_id, max(salary)
from employees group by department_id;  --각 부서별 최고의 급여

select employee_id,
       first_name,
       salary,
       department_id
from employees
where (salary, department_id)
    in (select max(salary), department_id
        from employees group by department_id)
order by salary desc;

--2)테이블조인
select e.employee_id,
       e.first_name,
       e.salary,
       e.department_id, d.department_id
from employees e, 
     (select department_id, max(salary) maxSalary
      from employees group by department_id) d
where e.department_id=d.department_id
      and e.salary=d.maxSalary
order by e.salary desc;


--문제6.각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오
--(19건)
select sum(salary), job_id
from employees group by job_id; --업무별로 연봉의 총합

select jo.job_title,
       salary
from jobs jo, employees e
where jo.job_id=e.job_id;

select jo.job_id,
       jo.job_title 업무명,
       e.salary 연봉총합
from jobs jo, employees e,
     (select sum(salary) sumSalary, job_id
      from employees group by job_id) s
where jo.job_id=s.job_id and e.salary=s.sumSalary
order by e.salary desc;
      


--문제7.자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의
--직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요
--(38건)
select department_id, avg(salary)
from employees group by department_id; --부서 평균급여

select employee_id 직원번호,
       first_name 이름,
       salary 급여
from employees e, (select department_id, avg(salary) avgSalary
                   from employees group by department_id)avg
where e.department_id=avg.department_id
      and e.salary>avg.avgSalary;



--문제8. 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을
--입사일 순서로 출력하세요
select rownum, first_name, hire_date
from employees order by hire_date asc; --직원 입사일 순서대로 정리

select rn,
       employee_id,
       first_name,
       salary,
       hire_date
from (select rownum rn, employee_id, first_name, salary, hire_date
      from (select employee_id, first_name, salary, hire_date from employees order by hire_date asc))
where rn>=11 and rn<=15;


