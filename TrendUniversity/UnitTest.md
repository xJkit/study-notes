# Unit Testing

> Andy Tzeng

* 聖經：The Art of Unit Testing: with examples in C#, 2/e

* Assignments:
  * 11/1 12PM
  * 11/8 12PM
  * 11/15 12PM
* Final Presentations:
  * current status of testing adoption
  * brief adopt/improve UT of your daily project
  * adoption skills
* iShare2 ETC site
  * 創建以名字的資料夾

## 20171026

* Definition of UT
  * SUT: System Under Test
  * CUT: Code Under Test
* Good UT
  * [x] Automated, repeatable
  * [x] EZ to implement (need framework)
  * [x] EZ to run
  * [x] EZ to detect & pinpoint the problem
  * [x] Run quickly
  * [x] Full control of unit under test(no - *ependencies)
  * [x] Fully isolated
  * [x] Almost use framework to test(ez, fast)

* IT
  * Real Env
  * automated & repeatable (dependent, high cost)
  * Hard to implement
  * Hard to run
  * Hard to identify root cause
  * Run slowly
  * Not full control
  * Posibly hidden problems
  * Low code coverage

* Testing **V** Model

* Test Framework offers:
  * class libraries, test runner, test results(summaries)

## 20171102

* External Dependencies:
  * Time
  * Network
  * 3-party lib
  * Memory
  * ...

* Dependency Breaking
* Refactoring
  * change code but not behaviour

* Methods
  * Constructor injection

## References

* [ghsukumar GitHub 整理好的 UT 原則](https://github.com/ghsukumar/SFDC_Best_Practices)