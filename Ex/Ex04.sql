/********************************
*** SubQuery ***
********************************/
--■ SubQuery : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태
--• SubQuery 부분은 where 절의 연산자 오른쪽에 위치해야 하며 괄호로 묶어야한다.
--• 가급적 order by 를 하지 않는다.
--• 단일행 SubQuery 와 다중행 SubQuery 에 따라 연산자를 잘 선택해야함

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
select first_name,
       salary
from employees
where first_name = 'Den';

select first_name,
       salary
from employees
where salary>=11000;

select first_name,
       salary
from employees
where salary>=(select salary
               from employees
               where first_name='Den');


-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
select first_name,
       salary,
       employee_id
from employees
where salary=(select min(salary)
              from employees);


-- 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
select first_name,
       salary
from employees
where salary<(select avg(salary)
              from employees)
order by salary desc;


--■ 다중행 SubQuery
--• subQuery의 결과가 여러 Row인 경우
--• 연산자 : ANY, ALL, IN ...


--■ 다중행 SubQuery - IN

--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
select *
from employees
where department_id =110;

select *
from employees
where salary=12008 or salary=8300;

select employee_id,
       first_name,
       salary,
       department_id
from employees
where salary in (select salary
                 from employees
                 where department_id=110);
--where salary = 12008 or salary = 8300


-- 각 부서별로 최고급여를 받는 사원을 출력하세요










