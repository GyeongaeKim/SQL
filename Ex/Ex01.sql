/*********************
select 문
    select 절
    from 절
***********************/

--모든 컬럼 조회하기
select * from employees;
select * from departments;

--원하는 컬럼만 조회하기
select employee_id, first_name, last_name 
from employees;

--예제)
--사원의 이름과 전화번호, 입사일을 출력하세요
select first_name, phone_number, hire_date from employees;

--사원의 이름/성과 급여, 전화번호, 이메일, 입사일을 출력하세요
select first_name, 
    last_name, 
    salary, 
    phone_number, 
    email, 
    hire_date 
from employees;



--출력할때 컬럼명 별명 사용하기
--사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select first_name "이름",
        phone_number "전화번호",
        hire_date "입사일",
        salary "급여"
from employees;

--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select employee_id as 사원번호,  /*별명사용의 정석*/
        first_name 이름,          /*as 생략 가능*/
        last_name "lastname",    /*소문자, 공백, 특수문자 등이 필요한경우->큰따옴표*/
        salary "급 여",
        phone_number "전화번호",
        email "이메일",
        hire_date "입사일"
from employees;



--연결연산자(컬럼들 붙이기)
select first_name, last_name from employees;

select first_name || last_name from employees;
select first_name || ' ' || last_name from employees;
select first_name || ' hire date is ' || hire_date 입사일 from employees;



--산술 연산자
select first_name,
        salary,
        salary*12,
        (salary+300)*12
from employees;

--숫자만 산술연산자를 사용할 수 있음!
select job_id*12 from employees;

--전체직원의 정보를 다음과 같이 출력하세요
select first_name || '-' || last_name 성명,
        salary 급여,
        (salary*12) 연봉,
        (salary*12+5000) 연봉2,
        phone_number 전화번호
from employees;





/*where 절*/
--•부서번호가 10인 사원의 이름을 구하시오
select * 
from employees
where department_id = 10;

--연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
select first_name, salary from employees where salary>=15000;

--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name, hire_date from employees where hire_date>='07/01/01';
--집에서 하면 영어버전이라서, 아래처럼 표기해야 됨
select first_name, hire_date from employees where hire_date>='01-jun-07';

--이름이 Lex인 직원의 연봉을 출력하세요
select first_name, salary from employees where first_name='Lex';



--조건이 2개이상 일때 한꺼번에 조회하기
--•연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name, salary from employees where salary>=14000 and salary<=17000;

--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select first_name, salary from employees where salary<=14000 or salary>=17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name, hire_date from employees where hire_date>='04/01/01' and hire_date<='05/12/31';

select first_name, hire_date from employees where hire_date>='01-jan-04' and hire_date<='31-dec-05';



--BETWEEN 연산자로 특정구간 값 출력하기
--•연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name, salary from employees where salary between 14000 and 17000;

--•연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name, salary from employees where salary >= 14000 and salary <= 17000;



--IN 연산자로 여러 조건을 검사하기
select first_name, last_name, salary from employees where first_name in ('Neena', 'Lex', 'John');

-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select first_name, salary from employees where salary in(2100, 3100, 4100, 5100);



--■ Like 연산자로 비슷한것들 모두 찾기
select first_name, last_name, salary from employees where first_name like 'L%';
select first_name, last_name, salary from employees where first_name like 'L___';
select first_name, last_name, salary from employees where first_name like '%s';


-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select first_name, salary from employees where first_name like '%am%';

-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select first_name from employees where first_name like '_a%';

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name from employees where first_name like '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name from employees where first_name like '_a__';



--■ NULL/아무런 값도 정해지지 않았음을 의미 (0이 아님)
select first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000;

select first_name, salary, commission_pct
from employees
where commission_pct is null;       /* A =  null 이 아님!!! */

-- 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name, commission_pct from employees where commission_pct is not null;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name from employees where manager_id is null and commission_pct is null;





--■ order by 절을 사용해 보기 좋게 정렬하기
--desc 내림차순(큰거작은거) / asc 오름차순(작은거큰거)
select first_name, salary from employees order by salary desc;
select first_name, salary from employees where salary>=9000 order by salary desc;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id, salary, first_name from employees order by department_id asc;
-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name, salary from employees where salary>=10000 order by salary desc;
-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select department_id, salary, first_name 
from employees order by department_id asc, salary desc;




/*
단일행 함수
*/
--■ 문자함수 - INITCAP(컬럼명)
--• 영어의 첫 글자만 대문자로 출력하고 나머지는 전부 소문자로 출력하는 함수
--부서번호 100인 직원의 이메일 주소와 부서번호를 출력하세요
select email, department_id from employees where department_id=100;
select email, initcap(email) email2 , department_id from employees where department_id=100;


--■ 문자함수 – LOWER(컬럼명) / UPPER(컬럼명)
--• 입력되는 값을 전부 소문자/대문자로 변경하는 함수
select first_name,
       upper(first_name),
       lower(first_name) 
from employees where department_id=100;


--■ 문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
--• 주어진 문자열에서 특정길이의 문자열을 구하는 함수
select first_name,
       substr(first_name,1,3),
       substr(first_name,-3,2)      /* 음수인 경우 뒤에서 몇번째 위치부터*/ 
from employees where department_id=100;


--■ 문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)
--• LPAD() :왼쪽 공백에 특별한 문자로 채우기
--• RPAD() :오른쪽 공백에 특별한 문자로 채우기
select first_name,
       lpad(first_name,10,'*'),
       rpad(first_name,10,'*')
from employees;

select first_name,
       (lpad(RPAD(first_name,length(first_name) + (10 - length(first_name)) / 2,'*'),10,'*')),
       lpad(rpad(first_name, 10, '*'), 15, '*')
       from employees;


--■ 문자함수 – REPLACE (컬럼명, 문자1, 문자2)
--• 컬럼명에서 문자1을 문자2로 바꾸는 함수
select first_name,
       replace(first_name,'a','*'),
       replace(first_name, substr(first_name,2,3),'***')
from employees where department_id=100;





--■ 숫자함수 – ROUND(숫자, 출력을 원하는 자리수)
--• 주어진 숫자의 반올림을 하는 함수
select round(123.346, 2) r2,
       round(123.456, 0) r0,
       round(123.456, -1) "r-1"
from dual;


--■ 숫자함수 – TRUNC(숫자, 출력을 원하는 자리수)
--• 주어진 숫자의 버림을 하는 함수
select trunc(123.346, 2) r2,
       trunc(123.456, 0) r0,
       trunc(123.456, -1) "r-1"
from dual;


--■ 날짜함수 – SYSDATE()
--• 현재날짜와 시간을 출력해주는 함수
select sysdate from dual;


--■ 단일함수>날짜함수 – MONTH_BETWEEN(d1, d2)
--• d1날짜와 d2날짜의 개월수를 출력하는 함수
select months_between(sysdate, hire_date)
from employees where department_id = 110;


--■ TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로 변환하기 ;; 9또는 0
select first_name, to_char(salary*12, '$999,999.99') 급여
from employees where department_id=110;

select to_char(9876, '999999'),
       to_char(9876, '099999'),
       to_char(9876, '$99999'),
       to_char(9876, '9999.99'),
       to_char(987654321, '999,999,999'),
       to_char(987654321, '999,999,999,999')
from dual;


--■ 변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하기
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;

select sysdate,
       to_char(sysdate, 'yyyy-mm-dd'), 
       to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS'),
       to_char(sysdate, 'yyyy'),
       to_char(sysdate, 'yy'),
       to_char(sysdate, 'MM'),
       to_char(sysdate, 'month'),
       to_char(sysdate, 'DD'),
       to_char(sysdate, 'day'),
       to_char(sysdate, 'hh24'),
       to_char(sysdate, 'mi'),
       to_char(sysdate, 'ss')
from dual;


--■ 일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
--• NVL(조사할 컬럼, NULL 일 경우 치환할 값)
--• NVL2(조사할 컬럼, NULL이 아닐때 치환할 값, NULL일때 치환할 값)
select first_name,
       commission_pct,
       nvl(commission_pct, 0),
       nvl2(commission_pct, 100, 0)
from employees;









