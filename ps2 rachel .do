Rachel Wagner 
Problem Set 2
October 4th 2018 

version 15
set more off
cap log close 
sysdir

pwd// where 
ls
cd DirectedStudy 
ls 

*books
insheet using /home/u1/Downloads/book.csv, clear
ta subject
//edit isbn13
format  %16.0g isbn13
tostring isbn13, gen(isbn13s) u
//edit isbn*
save books, replace
//ls
destring price, gen(priced) ignore("$")
collapse priced, by(subject)
l


*goodreads

insheet using /home/u1/Downloads/100kSamplOfAllSeed4694329905allBooksReadMin1revV1.csv, clear


l readat  in 1/100
gen rachelDate=substr(readat,5,6)
//Mon Mar 10
edit readat rachelD


//can take random sample from goodreads to make things faster 
sample 10

sort isbn13
edit isbn13
ren isbn13 isbn13s

merge m:1 isbn13s using books


edit if _merge==3


***************

*holidays 
insheet using /home/u1/Downloads/holidays.csv, clear nam
ta date
save holidays, replace 
//many to many... not good 

gen count=1
collapse (sum) count, by(date)  
l
merge m:1 date using holidays 
//'varialbe date does not uniquely identify observations in the using data' 

keep date
d

*goodreads
insheet using /home/u1/Downloads/100kSamplOfAllSeed4694329905allBooksReadMin1revV1.csv, clear
rename readat date (*variable does not uniquely identify obs)
d using holidays 

*merge ** problems merging holidays because no var recognized :(
merge m:1 date using holidays
ta date
*too many dates*
ta date using holidays 
*'using' not allowed* 
:( 


