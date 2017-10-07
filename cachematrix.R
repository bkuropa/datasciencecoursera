## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
      invMat <- NULL  #clear old matrix
      # Move y into global level
      set <- function(y) {
            x <<- y
            invMat <<- NULL
      }
      # Pull x into current function
      get <- function() x
      
      #Move inverse into cache
      setInv <- function() invMat <<- solve(x)
      #Pull inverse into current function
      getInv <- function() invMat
      
      #Show results
      list(set = set, get = get, 
           setInv = setInv, 
           getInv = getInv)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
      ## Return a matrix that is the inverse of 'x'
      invMat <- x$getInv()
      
      if(!is.null(invMat)){
            message("getting cached matrix data")
            return(invMat)
      }
      
      data <- x$get()
      invMat <-solve(data, ...)
      x$setInv(invMat)
      invMat
}
