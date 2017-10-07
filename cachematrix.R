## Put comments here that give an overall description of what your
## functions do

## Make lists of which matricies have been cached from variable "x"
makeCacheMatrix <- function(x = matrix()) {
      invX <- NULL  #clear old matrix
      # Move y into current cache
      set <- function(y) {
            x <<- y
            invX <<- NULL
      }
      # Pull x into current function
      get <- function() x
      
      #Move inverse into cache
      setInv <- function(inverted) invX <<- inverted
      #Pull inverse into current function
      getInv <- function() invX
      
      #Show results
      list(set = set, get = get, 
           setInv = setInv, 
           getInv = getInv)
}


## Check if matrix is cached and solve it

cacheSolve <- function(x, ...) {
      ## Return a matrix that is the inverse of 'x'
      invX <- x$getInv()
      # If the inverse is not empty, pull from cache (no math)
      if(!is.null(invX)){
            message("getting cached matrix data")
            return(invX)
      }
      # If the Inv.Mat. is empty, do the math
      data <- x$get()
      invX <-solve(data,...)
      x$setInv(invX)
      invX
}
