#data
aiVectors <- list(
  c(0, 0, 20, 35, 45), c(0, 0, 15, 35, 50), c(10, 15, 20, 25, 30), c(0, 12, 23, 30, 35),
  c(0, 1, 26, 36, 37), c(0, 3, 18, 38, 41), c(1, 2, 29, 33, 35), c(0, 15, 22, 29, 34), c(4,4,4,36,52))

pythonVectors <- list(c(0, 6, 18, 30, 46), c(0, 8, 19, 34, 39), c(0, 12, 19, 32, 37), c(0, 12, 24, 31, 33), c(0, 12, 23, 30, 35), c(0, 8, 23, 22, 47), 
                      c(0, 15, 22, 29, 34), c(1, 8, 15, 34, 42), c(0, 9, 21, 39, 31), c(0, 8, 12, 35, 45), c(1, 6, 17, 25, 51), c(0, 13, 20, 38, 29), 
                      c(0, 12, 26, 34, 28), c(2, 9, 25, 33, 31), c(0, 3, 18, 38, 41), c(0, 5, 32, 28, 35), c(2, 13, 14, 34, 37), c(0, 3, 26, 37, 34), 
                      c(3, 14, 16, 33, 34), c(1, 5, 12, 35, 47), c(3, 12, 15, 37, 33), c(2, 9, 28, 33, 28), c(0, 13, 9, 33, 45), c(0, 2, 22, 34, 42), 
                      c(1, 6, 14, 23, 56), c(5, 9, 15, 31, 40), c(2, 14, 23, 18, 43), c(2, 4, 20, 23, 51), c(1, 5, 12, 42, 40), c(0, 4, 33, 33, 30), 
                      c(1, 3, 19, 23, 54), c(4, 13, 15, 36, 32), c(4, 8, 30, 24, 34), c(2, 3, 22, 23, 50), c(3, 7, 31, 28, 31), c(0, 3, 34, 25, 38), 
                      c(0, 4, 34, 20, 42), c(4, 17, 15, 23, 41), c(1, 20, 17, 18, 44), c(5, 4, 22, 25, 44), c(5, 15, 14, 25, 41), c(4, 11, 23, 18, 44), 
                      c(1, 19, 12, 21, 47), c(5, 14, 23, 22, 36), c(2, 8, 26, 39, 25), c(2, 9, 28, 36, 25), c(1, 18, 10, 24, 47), c(3, 18, 17, 19, 43), 
                      c(6, 8, 18, 36, 32), c(4, 6, 31, 24, 35))

#combined <- unique(c(pythonVectors, aiVectors))
combined <- aiVectors

#pit against each other first time
vecBattle <- function(data){
  newVector <- as.vector(rmultinom(1, size = 100, prob = rep(1/5, 5)))
  score <- 0
  
  for(j in seq_along(combined)){
    contender <- data[[j]]
    
    for(i in seq_along(newVector)){
      if(newVector[i] > contender[i]){
        score <- score + i
      }else if(newVector[i] == contender[i]){
        score <- score + i/2
      }
    }
  }
  
  return(c(score, newVector))
}

#actually run this shit
#runShit <- function(data)
  
totalOptions <- list()
runTimes = 10000
for (i in 0:runTimes){
  result <- vecBattle(combined)
  totalOptions <- append(totalOptions, list(result))
  
  if(i == runTimes/2){
    print("progress has been achieved...")
  }
}

#sort for winners (switch to matrix)
results <- do.call(rbind, totalOptions)
sorted <- results[order(-results[, 1]), ]
best <- head(sorted, 10)

#mutate bullshit
#best2 <- runShit(combined)
bestList <- lapply(seq_len(nrow(best)), function(i) best[i, 2:6])
bestList

mutated <- list()

for(i in seq_along(bestList)){
  changes <- sample(1:5, 2, replace = FALSE)
  change <- sample(-2:2, 1)
  vec <- bestList[[i]]
  vec[changes[1]] <- vec[changes[1]] + change
  vec[changes[2]] <- vec[changes[2]] - change
  mutated[[i]] <- vec
}

#mutated

#run iterative vs previous plus former best
#combined <- unique(c(combined + bestList))



