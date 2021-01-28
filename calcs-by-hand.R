#----------------------------------------------------------
# This script sets out to produce functions to compute some
# Bayesian models based off audience interaction
#----------------------------------------------------------

#------------------------ Prior ------------------------------

make_a_prior_table <- function(go8_belief){
  
  if (!isTRUE(all(go8_belief > 0)) | !isTRUE(all(go8_belief <= 1))){
    stop("Go8 belief probability should be a floating point value or vector of values between 0 and 1.")
  }
  
  if(length(go8_belief) > 1){
    
    go8_belief <- mean(go8_belief)
    
  } else{
    
  }
  
  tmp <- data.frame(hypothesis = c("Go8", "non-Go8"),
                    degree_of_belief = c(go8_belief, (1-go8_belief)))
  
  if (sum(tmp$degree_of_belief) != 1){
    stop("Probabilities should sum to 1.")
  }
  
  return(tmp)
}

#------------------------ Posterior -------------------------

compute_posterior_table <- function(international_go8, international_non_go8){
  
  if (!isTRUE(international_go8 > 0) | !isTRUE(international_go8 <= 1) |
      !isTRUE(international_non_go8 > 0) | !isTRUE(international_non_go8 <= 1)){
    stop("Probabilities should be a floating point value between 0 and 1.")
  }
  
  tmp <- data.frame(hypothesis = c("Go8", "non-Go8", "TOTAL"),
                    International = c(international_go8, international_non_go8, international_go8+international_non_go8),
                    Domestic = c(0,0,0))
  
  if (international_go8+international_non_go8 != 1){
    stop("Marginal probability must equal 1.")
  }
  
  return(tmp)
}
