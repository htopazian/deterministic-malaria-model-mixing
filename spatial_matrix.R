a <- 1.91
log_p <- 4.29
t <- 1.22

pfpr <- matrix(data = c(10, 20, 25,
                        10, 20, 5,
                        10, 20, 5),
              nrow = 3,
              ncol = 3)
pfpr

pop <- matrix(data = c(100, 100, 100,
                       1000, 1000, 1000,
                       500, 500, 2000),
               nrow = 3,
               ncol = 3)
pop


(1000 ^ t) * (1 + (1 / exp(log_p)))^(-a)
