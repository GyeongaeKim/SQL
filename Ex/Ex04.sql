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


--2022-05-17
--11000보다 급여를 많이 받는 사람의 이름과 급여는?
select first_name,
       salary
from employees
where salary>11000;

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는? *Den의 급여는 11000;
select first_name,
       salary
from employees
where salary>(select salary
              from employees
              where first_name='Den');



--부서번호가 110인 직원/급여
select first_name,
       salary 
from employees
where department_id=110;

--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여
select department_id,
       first_name,
       salary
from employees
where salary in (select salary 
                 from employees
                 where department_id=110);


-- 각 부서별로 최고급여를 받는 사원을 출력하세요 *이름은 표현할 수 없다
select department_id,
       max(salary)
from employees
group by department_id;

select department_id,
       employee_id,
       first_name,
       salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);



  
  
  
/********************************
*** SubQuery ***
********************************/
--■ 다중행 SubQuery - ANY (or)
--부서번호가 110인 직원의 급여 보다 큰 모든 직원의
--사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
select employee_id,
       first_name,
       salary
from employees
where salary>8300 or salary>12008;

select employee_id,
       first_name,
       salary
from employees
where salary >any (select salary
                   from employees
                   where department_id=110);

--■ 다중행 SubQuery - ALL (and)
select employee_id,
       first_name,
       salary
from employees
where salary>8300 and salary>12008;

select first_name, 
       salary,
       department_id
from employees
where salary >all (select salary
                   from employees
                   where department_id=110);

--*** all / any 비교 ***
select employee_id, first_name, salary from employees 
where salary >all (select salary from employees where department_id=110);

select employee_id, first_name, salary from employees 
where salary >any (select salary from employees where department_id=110);



--■ 조건절에서 비교 vs 테이블에서 조인
-- 각 부서별로 최고급여를 받는 사원을 출력하세요
select department_id,
       employee_id,
       first_name,
       salary
from employees
where (department_id, salary) 
    in (select department_id, max(salary)
        from employees
        group by department_id);
        
select e.department_id,
       e.employee_id,
       e.first_name,
       e.salary
from employees e, (select department_id, max(salary) salary
                   from employees
                   group by department_id) s
where e.department_id=s.department_id
    and e.salary=s.salary;


-- 각 부서별로 최고급여를 받는 사원을 출력하세요
--조건절로 구하기
--1)부서별 최고급여
select department_id,
       max(salary)
       --first_name 이름을 넣으면 오류가 난다(group by때문에)
from employees
group by department_id;

--2)조건절 이용하여 값 구하기
select first_name,
       salary,
       department_id
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id);

-- 각 부서별로 최고급여를 받는 사원을 출력하세요
--테이블로 구하기
--1)부서별 최고급여
select max(salary),
       department_id
from employees
group by department_id;

--2)테이블 이용하여 값 구하기
select e.first_name,
       e.salary,
       e.department_id,
       s.department_id,
       s.maxSalary
from employees e, (select max(salary) maxSalary,
                          department_id
                   from employees
                   group by department_id) s
where e.department_id=s.department_id
      and e.salary=s.maxSalary;







/********************************
*** rownum ***
********************************/
--■ rownum : 질의의 결과에 가상으로 부여되는 Oracle의 가상(Pseudo)의 Column (일렬번호)

-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
select rownum,
       employee_id,
       first_name,
       salary
from employees
order by salary desc; --정렬시 rownum이 섞인다.


select rownum,
       ot.employee_id,
       ot.first_name,
       ot.salary
from (select employee_id,
             first_name,
             salary
      from employees
      order by salary desc) ot; --정렬된 테이블을 사용하여 rownum매겨준다.

select rownum,
       ot.employee_id,
       ot.first_name,
       ot.salary
from (select employee_id,
             first_name,
             salary
      from employees
      order by salary desc) ot
where rownum>=1 and rownum<=5;  --1~5등만 출력


select rownum,
       ot.employee_id,
       ot.first_name,
       ot.salary,
       ot.phone_number
from (select employee_id,
             first_name,
             salary,
             phone_number
      from employees
      order by salary desc) ot
where rownum>=1     --1부터 시작하지 않으면, 안됨.. 
    and rownum<=5;



select ort.rn,
       ort.employee_id,
       ort.first_name,
       ort.salary
from (select rownum rn,
             ot.employee_id,
             ot.first_name,
             ot.salary
      from (select employee_id,
                   first_name,
                   salary
            from employees
            order by salary desc) ot
      ) ort  
where rn>=11 and rn<=15;



-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?
select ort.rn,
       ort.first_name,
       ort.salary,
       ort.hire_date
from (select rownum rn,
             first_name,
             salary,
             hire_date
      from (select first_name,
                   salary,
                   hire_date
            from employees
            where to_char(hire_date, 'YYYY')=2007
            order by salary desc) ot
      ) ort
where rn>=3 and rn<=7;










    
                                  