library(tidyverse)
library(ICDMM)

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


# rebuild ICDMM
# odin::odin_package(getwd())
# click 'install and rebuild'

# run ICDMM
age_vector <- c(0,0.25,0.5,0.75,1,1.25,1.5,1.75,2,3.5,5,7.5,10,15,20,30,40,50,60,70,80)
year <- 365
EIR_vector <- c(1,10,100)

# isolated example
mixing <- matrix (c(1,0,0,
                    0,1,0,
                    0,0,1),
                  nrow=3)

# mixed example
mixing <- matrix (c(.33,.33,.33,
                    .33,.33,.33,
                    .33,.33,.33),
                  nrow=3)

out <- run_model_metapop(model = "odin_model_metapop",
                         het_brackets = 5,
                         age = age_vector,
                         init_EIR = EIR_vector,
                         init_ft = 0.4,
                         mix = mixing,
                         time = 3 * year,
                         # num_int = num_int,
                         # ITN_on = 1,
                         # ITN_interval = 3 * year,
                         irs_cov = c(0,0,0),
                         itn_cov= c(0,0,0))

model <- cbind(out$t, out$prev2to10) %>% as_tibble()
colnames(model) <- c('t', EIR_vector)
model <- model %>% pivot_longer(cols = 2:4, names_to = 'EIR', values_to = 'prev2to10')
model


ggplot(data = model) +
  geom_line(aes(x = t, y = prev2to10, group = EIR, color = EIR)) +
  labs(x = 'time (days)',
       y = 'PfPR 2-10',
       color = 'EIR') +
  theme_classic()




