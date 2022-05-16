/********************************
*** JOIN ***
********************************/
--■ 둘 이상의 테이블을 합쳐서 하나의 큰 테이블로 만드는 방법

--■ 두 테이블에서 그냥 결과를 선택하면?
--• 결과: 두 테이블의 행들의 가능한 모든 쌍이 추출됨
select * from employees, departments;
select count(*) from employees, departments, jobs;
--• 올바른 Join조건을 WHERE 절에 부여 해야 함.
--양쪽다 만족하는 경우만 조인됨null은 조인안됨(제외됨)
select employee_id,
       first_name,
       salary,
       department_name,
       employees.department_id  --컬럼 이름의 모호성을 피하기 위해(어느 테이블 에 속하는지 알 수 없음)
from employees, departments
where employees.department_id = departments.department_id;

select employee_id,
       first_name,
       salary,
       department_name,
       em.department_id,
       de.department_id
from employees em, departments de       --테이블에 별명주기
where em.department_id = de.department_id;


--[예제] 모든 직원이름, 부서이름, 업무명 을 출력하세요
select e.first_name 직원이름,
       d.department_name 부서이름,
       j.job_title 업무명
from employees e, departments d, jobs j
where e.department_id=d.department_id and e.job_id=j.job_id;

select e.first_name 직원이름,
       d.department_name 부서이름,
       j.job_title 업무명,
       e.salary,
       e.department_id,
       d.department_id,
       e.job_id,
       j.job_id       
from employees e, departments d, jobs j
where e.department_id=d.department_id 
      and e.job_id=j.job_id 
      and e.salary>=7000
order by e.salary desc;





/********************************
*** JOIN ***
********************************/
--equi join 데이터 106개 --> null은 포함되지 않는다
select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from employees e, departments d
where e.department_id=d.department_id;


--■ right outer join
--• 왼쪽 테이블의 모든 row를 결과 테이블에 나타냄
select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from employees e left outer join departments d
    on e.department_id=d.department_id;
    
select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from employees e, departments d
where e.department_id=d.department_id(+);



--■ right outer join
--• 오른쪽 테이블의 모든 row를 결과 테이블에 나타냄
select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from employees e right outer join departments d
    on e.department_id=d.department_id;

select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from employees e, departments d
where e.department_id(+)=d.department_id;


--■ right outer join  left outer join
select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from departments d left outer join employees e
    on e.department_id=d.department_id;


--■ full outer join
select e.first_name,
       e.department_id,
       d.department_name,
       d.department_id
from employees e full outer join departments d
    on e.department_id=d.department_id;


----■ Self join
--• 자기자신과 Join 
--• Alias를 사용할 수 밖에 없음
select *
from employees e, employees m
where e.manager_id=m.employee_id;

select e.employee_id,
       e.first_name,
       e.salary,
       e.phone_number,
       e.manager_id,
       m.employee_id,
       m.first_name,
       m.phone_number
from employees e, employees m
where e.manager_id=m.employee_id;



