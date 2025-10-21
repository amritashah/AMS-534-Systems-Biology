#########################################################################
#
#   Basic data types in R
#
#########################################################################

a=1 #  the [1] in the output is telling you R is printing the first (& only) element of the vector a

a <- 1 # also works. Stick with one or the other

#  Build vectors with the concatenate function c()
a=c(1,2,3); b=c(4,5,6)
c(a,b)

# vectors can be sets of objects of the same mode
v1=c(1,2,3)
v2=c("A", "B", "C")
v3=c(TRUE, FALSE, TRUE)

# lots of built-in functions; R tries to operate on them in vector fashion if possible
log(a)
sum(a)

# R will try to coerce objects into meaningful modes depending on what you are trying to do
# this converts TRUE and FALSE into 1 and 0:
sum(v3)
v1+v3

# R tries to recycle vectors when needed,so
a=c(1,2,3) + 1
a=c(1,2,3,4) + c(1,2)
# generally useful but can fail (or give silent errors) if you aren't careful
a=c(1,2,3,4) + c(1,2,3)

# making vectors
1:100
seq(1,100, by=2)
seq(from=1, to=9, len=20)
rep(c(1,2), len=4)
rep(c(1,2), each=2)
x=1:10; seq(from=1, to=2, along=x)

# building vectors from nothing
a=NULL; a=c(a, c(1,2,3))

# another vector operation
a=10^(1:5)

# Exercise (series) here ...

# You can also give names to elements of vectors.
# R interprets (or forces) the names to be character objects.
# asking for a vector's names returns a vector
a=c(x=1,y=1,z=1)
names(a)

# changing names
names(a) = c("first", "second", "third")

# Vectors can be combined into higher level objects
# Most common ones are matrices, dataframes, lists.
# We'll come to others later: they are mainly generalized lists - R uses these as the outputs of calculations

# matrix = rectangular array of atomic vectors of of the same mode (all characters, all numerics...)
a=matrix(c(1,2,3,4), nrow=2, byrow=TRUE)
rownames(a)= c("X", "Y")

# R has default behaviours - e.g. matrix(c(1,2,3,4)) makes a matrix with 1 column.
# dataframe - Generalization of a matrix - collection of vectors of the same length.
# very common & useful object to use when handling data.
 
lab=data.frame(name=c("Andy","Iren","Ulrich"),age=c(41,NA,NA), stringsAsFactors = FALSE)

# The functions rbind() and cbind() to combine objects by row or by column
# Can use to add rows or columns to a matrix

rbind(a,Z=c(8,9))

# To add to a data frame; new columns must be vectors of the same length as the existing entries
# (R will complain otherwise)

lab$OS=c("Mac", "Mac", "Linux")
lab=cbind(lab, gender=c("M", "F", "M"))

# Let's add a new row to the data frame
# New rows need to be a data frame with the same number of elements
# Look what happens to the "age" column when we add a character string to it,
# rather than a number as expected
lab=rbind(lab, data.frame(name=c("Albert Einstein"), age="Dead", OS="What?", gender="M"))

lab$age # R has coerced this to be a character vector rather than numeric.

# A list is the most general object in R
# - a collection of objects of any class and size - even a list of lists
list.example=list(andylab=lab, random.numbers=runif(100), logicals=c(T,F,F,F)) 

str(list.example) # summary of the structure of an object
names(list.example) # get the names of its components

###############################################################################
#
#   Referencing components of objects
#
###############################################################################

v=c(1,4,9,16,25)

# indices start at 1; use square brackets to reference parts of vectors
v[1]

v[c(1,2,3)] # a vector; square brackets enclose the elements of v that we want
v[1:3] # remember 1:3 is shorthand for c(1,2,3)

## Exercise here (indexing)

# logical tests - all return vector objects
v>3
v==4
v!=4

# An example of logical indexing
v[c(TRUE, TRUE, FALSE, TRUE, FALSE)]

# although careful about recycling...
v[c(TRUE, FALSE)]

# This is the basis of extracting bits of objects with conditional statements
# here, sqrt(v)>3 is a vector of logicals, with length v
v[sqrt(v)>3]
 
v[v<1 | v>10]
z=v[v<1 & v>10] # numeric vector of length zero

# resampling from elements of a vector - very useful for bootstrapping and reshuffling
v[c(1,2,3,4,5)] 
sample(v)
sample(v, size=20, replace = TRUE)
sample(v, size=20, replace = FALSE) # not sensible

# indexing by name
a=c(J=100, K=200, L=300)
a[["J"]] # useful if you want to reference elements by a character string
entry="K"
a[[entry]]= 0

# Elements of matrices;
a=matrix(runif(25), nrow=5, byrow=TRUE)

a[2,3] # 2nd row, 3rd column
a[1,]  #= first row = vector    ## In Matlab a(1,:)
a[,2]  #= second col, also a vector

#extract dimensions  - returns a vector = (rows, cols)
dim(a)

# add some column names. Join strings with "paste"
colnames(a) = paste("Column.", 1:dim(a)[2], sep="")

# Note several things here:
# The first element in paste is of length 1, the second is a vector 1:5; R recycles "Column."
# Rather than using 1:5 for the column numbers, we were safe and used dim(a)
# sep="" means we put no spaces between the things we are joining

rownames(a)=letters[1:dim(a)[1]]
a[rownames(a)=="b",]

a[2,] # same thing
a[1:2, 3]  # submatrix
 
# Dataframes; these are all equivalent
a = lab
a[["name"]]
a[,1] # first column of a
a$name

#rows; a[,1]
#subsets
a[a$name>"J",]
a[subset(a, name>"J")]

# Extracting parts of lists or dataframes (one way of doing it)
names(list.example)
list.example$logicals

# multiple subsetting
list.example$andylab$name

# control statements &, |, <=, == etc.
1==2

# changing elements
v=runif(10)
v[v<0.1]=0

# removing elements
v[-c(1,3)]

## Exercise (logical indexing) here ...

##########################################################
# 
# Sorting etc.
#
##########################################################

# Sort, order, rank, which
v=c(78,34,21,21,424,101)
sort(v, decreasing=TRUE)

# "order" returns the list of indices that correspond to the sorted entries in the vector 
places = order(v, decreasing=TRUE)
v[places]

# "rank" is similar but gives you the indices of the sorted entries, handles ties 
rank(v)
which(v<30)

##########################################################
# 
# Control Statements
#
##########################################################

a=1:10; b=11:20; ifelse(a>4, a, b)
a=if(2>1) 999 else 0

# comparison of vectors element-by-element:
c(TRUE, TRUE, FALSE) & c(TRUE, FALSE, FALSE) 


##########################################################
# 
# Searching and cross-referencing (towards relational databases)
#
##########################################################

# Use  %in% and match 
v=c(5,4,7,2,9,3) 

# Do elements of another vector appear in v?
c(1,2,3) %in% v

# At what positions in v do these elements appear?
match(c(1,2,3),v)

# (back to slides)

##########################################################
# 
# Functions
#
##########################################################

#Functions return the last expression evaluated inside it;
#...you can be clear about this by signalling exit with return() 

f=function(x) sum(x>10)

# more complex example
my.factorial=function(x){
	if (trunc(x)!=x || x<0) 
	{print("Ees no work"); 
	  return(NA)}
	if(x==0) return(1) # 0! is defined to be 1
	f=1
	temp=x
	while(temp>1) {
	  f=f*temp
	  temp=temp-1
	}
	return(f)  # this line could be just "f"
	}

# R has the same thing built-in... factorial(x)


##########################################################
# 
#  FOR loops are usually slow
#
##########################################################
v=1:1e6   
sumsq=0
system.time(for(i in 1:length(v)) sumsq=sumsq+v[i]^2)
#Compare to 
system.time(sum(v^2))

## Exercise here ...

##########################################################
# 
#  Repeated operations
#
##########################################################

# Using apply to operate on rows or cols of matrices
m=matrix(c(70,12,42,87,19,25,67,12,89),nrow=3, byrow=TRUE)
apply(m, MARGIN=2,FUN=sort, decreasing=TRUE)

# sapply to apply a function to each element of an object
sapply(1:10, seq)

# can use nameless functions
sapply(1:10, function(x){x^2})
# same as (1:10)^2


##########################################################
# Data for question 2 

test.scores=data.frame(
	name=c("A", "B", "C"),
	score1=c(80,90,NA),
	score2=c(56,NA,34),
	score3=c(76,78,23),
	score4=c(23,NA,67),
	score5=c(98,NA,99)
	)



