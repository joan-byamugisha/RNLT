## this programme calculates the inverse of a matrix
## the value of the inverse of the matrix is saved in an object, where,
## if the same matrix requires its inverse again,
## its value can be retrieved from the object in which it was stored

## this function gets the cached matrix, sets its value to that of the argument of the calling function
## sets the value of the object that has the value of the inverse of the matrix, and retrieves the value of the inverse object
## it uses non-local assignment to modify the value of objects in different environments
makeCacheMatrix <- function(x = matrix()) {
	## the object to hold the inverse
	i <- NULL
	## setting values to x and i using non-local assignment, because x and i are not being assigned in the environment they were defined
	set <- function(y) {
		## x is non-locally assigned the value of y
		x <<- y
		## i is non-locally assigned the initial value null
		i <<- NULL
	}
	## retrieving the matrix object
	get <- function() x
	## non-locally assigning the value of the calculated inverse to i
	setInv <- function(solve) i <<- solve
	## retrieving the value in the object i
	getInv <- function() i
	## creating a list to ensure access to the values of x and i
	list(set = set, get = get, setInv = setInv, getInv = getInv)
}

## this function uses the values in the list from the makeCacheMatrix() function
## to avoid recalculating the inverse of a matrix whose inverse has previously been calculated
cacheSolve <- function(x, ...) {
	## getting the cached inverse
	i <- x$getInv()
	## obtaining the cached matrix
	m <- x$get()
	## ensuring that the inverse has not been calculated and that the matrix has not changed
	if(is.null(i)) {
		## calculating the inverse since it has not previously been calculated
		i <- solve(m, ...)
		## caching the result
		x$setInv(i)
		return(i)
	} else {
		## if the inverse has already been calculated, check whether the cached matrix and argument matrix are identical
		if(identical(x, m)) {
			## retrieve the cached matrix
			message("Getting cache data...")
			return(i)
		} else {
			## if the inverse object is not null and the matrices are not identical
			## set the value of the inverse object to null and the value of the matrix object to that of the matrix argument
			x$set(x)
			## get the matrix and inverse objects
			m <- x$get()
			i <- x$getInv()
			## calculate the inverse
			i <- solve(m, ...)
			## cache the result
			x$setInv(i)
			return(i)
		}
	}
}
