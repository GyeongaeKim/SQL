/********************************
*** 그룹함수 ***
********************************/
select first_name, sum(salary) from employees;
--여러값(이름)과 한개의 값(합)을 동시에 출력할 수 없다

select sum(salary) from employees;


--■ 그룹함수 - count()
--• 함수에 입력되는 데이터의 총 건수를 구하는 함수
select count(*),  --count(*) : null포함
       count(commission_pct),    --null제외
       count(manager_id)
from employees;

select count(*) from employees where salary>16000;


--■ 그룹함수 - sum()
--• 입력된 데이터들의 합계 값을 구하는 함수
select count(salary),
       sum(salary)
from employees;


--■ 그룹함수 - avg()
--• 입력된 값들의 평균값을 구하는 함수
--• 주의: null 값이 있는 경우 빼고 계산함 – nvl 함수와 같이 사용
select avg(salary),         --급여가 null인 사람은 평균계산 제외
       avg(nvl(salary, 0)), --null값은 0으로 변경 후, 평균 계산
       round(avg(salary)),
       count(*),
       sum(salary)
from employees;


--■ 그룹함수 - max() / min()
--• 입력된 값들중 가장 큰값/작은값 을 구하는 함수
--• 여러건의 데이터를 순서대로 정렬 후 값을 구함-> 데이터가 많을 때는 느림(주의해서 사용)
select max(salary),
       min(salary),
       count(*)
from employees;





/********************************
*** GROUP BY절 ***
********************************/
select first_name
from employees
where salary>16000
order by salary desc;

select department_id,
       salary
from employees
order by department_id asc;

select department_id,
       avg(salary),          --부서별 평균
       sum(salary),          --부서별 합계
       count(salary)         --부서별 카운트
from employees
group by department_id      --group by에 참여한 컬럼이나 그룹함수만 올 수 있음!
order by department_id asc;

select department_id,
       job_id,
       avg(salary),          --부서별 평균
       sum(salary),          --부서별 합계
       count(salary)         --부서별 카운트
from employees
group by department_id, job_id      --group by에 참여한 컬럼이나 그룹함수만 올 수 있음!
order by department_id asc;

select job_id,
       avg(salary)
from employees
group by department_id, job_id;

select department_id,
       count(*),
       sum(salary)
from employees
--where sum(salary)>=20000      *where절에는 그룹함수를 쓸 수 없음.
group by department_id;





/********************************
*** HAVING절 ***
********************************/
select department_id,
       count(*),
       sum(salary)
from employees
--where sum(salary)>=20000      *where절에는 그룹함수를 쓸 수 없음.
group by department_id
having sum(salary)>=20000;      --대신 having절을 쓰면 가능!

select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary)>=20000 
       and sum(salary)<=100000;

select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary)>=20000
       and sum(salary)<=100000
     --and hire_date>='04/01/01'   *having절에는 그룹함수와 group by에 참여한 컬럼만 사용가능
       and department_id=90;

select department_id,
       count(*),
       sum(salary)
from employees
where hire_date>='04/01/01'       --where와 having을 잘 구분할 것!
group by department_id
having sum(salary)>=20000
       and sum(salary)<=100000;





/********************************
*** CASE ~ END 문 ***
********************************/
--■ CASE ~ END 문
--• if ~else if~else 문과 유사
select employee_id,
       first_name,
       job_id,
       salary,
       case when job_id='AC_ACCOUNT' then salary+salary*0.1
            when job_id='SA_REP' then salary+salary*0.2
            when job_id='ST_CLERK' then salary+salary*0.3
            ELSE salary
       END realSalary   -->컬럼명
from employees;


--■ DECODE 문 (CASE ~ END 비교)
select employee_id,
       first_name,
       job_id,
       salary,
       decode(job_id, 'AC_ACCOUNT', salary+salary*0.1,
                      'SA_REP',     salary+salary*0.2,
                      'ST_CLERK',   salary+salary*0.3,
              salary) bonus
from employees;

-- 직원의 이름, 부서, 팀을 출력하세요
--팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
--60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select first_name,
       department_id,
       case when department_id>=10 and department_id<=50   then 'A팀'
            when department_id>=60 and department_id<=100  then 'B팀'
            when department_id>=110 and department_id<=150 then 'C팀'
            else '팀없음'
       end 팀 
from employees;




