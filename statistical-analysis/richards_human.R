#################################################################
########## Richards’ growth Generalized Linear Model ############
#################################################################

### 30/05/2023
### Marco Mingione



# Packages
require(tidyverse)
require(magrittr)
require(lubridate)
require(zeallot)
Sys.setlocale(locale = "C")

# This code is available from the author upon request
source("richards_mle/Fun_DRichFit_Off.R")

# Prepare links to read from github repo
yrs <- 2012:2022
fls_umana <- paste0("/wn-ita-regioni-sorveglianza-umana-", yrs, ".csv")

links <- paste0("https://raw.githubusercontent.com/fbranda/west-nile/main/", yrs, "/dati-sorveglianza-umana", fls_umana)

# Read data
# Human
dat_wn <- map_dfr(links[grep("human", links)], 
                  function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) }) %>% 
  group_by(data, name_region) %>% 
  summarise(new_cases = sum(new_cases, na.rm = T)) %>% ungroup()

regY <- dat_wn %>% distinct(name_region, Y = year(data)) %>% arrange(name_region, Y)

# Data preparation
data_model <- dat_wn %>% 
  group_by(name_region, year(data)) %>% 
  mutate(ti = as.numeric(unclass(factor(data)))) %>%
  rename(ti_orig = data, region = name_region) %>% 
  group_split()

# Auxiliary ---------------------------------------------------------------

fit_richards <- function(dat, fam = "Negative Binomial", horizon = 0, off = 1, Xcov = NULL){
  #fam <- "Poisson" # or Poisson
  #horizon <- 0
  # mi salvo le date
  ti_orig_out <- dat$ti_orig %>% unique()
  
  # Metto solo l'intercetta come covariata
  X <- cbind(rep(1, nrow(dat)), Xcov)
  
  # Scegliere la variabile per il modello: l'ho chiamata sempre NP (Nuovi Positivi)
  whidx <- which(colnames(dat)=="new_cases")
  anyneg <- dat[, whidx, drop = T]<0
  if(any(anyneg)){
    for(i in which(anyneg)){
      dat[i, whidx, drop = T] <- mean(c(dat[i-1, whidx, drop = T], dat[i+1, whidx, drop = T])) 
    }
  }
  pc_allobs <- dat[, whidx, drop = T] # conteggi osservati
  pc_fit <- pc_allobs
  ti_fit <- dat %$% ti # tempi osservati numerici
  ti_orig_fit <- dat %$% ti_orig # tempi osservati scala datetime
  
  # istanti di previsione
  if(horizon > 0){
    ti_orig_hor <- as.Date(seq(min(ti_orig_fit), max(ti_orig_fit) + 7*horizon, 7)) # weekly 
  }else{
    ti_orig_hor <- ti_orig_fit
  }
  mti <- max(ti_fit)
  timax <- mti+horizon
  # Seleziono covariate di riferimento
  X_fit <- as.matrix(X[ti_fit,])
  
  np <- tryCatch(
    growthGLM(di = pc_fit, ti = ti_fit, alpha = .1, family = fam, tPred = timax, X = X_fit, 
              maxiter = 1000, runs = 2000, nBoot = 5000, off = off),
    error = function(e){return("Error")}
  )
  
  # Sistemo l'output
  fitTib <- tibble(ti_orig=ti_orig_fit, pc=pc_fit)
  horTib <- tibble(ti_orig=ti_orig_hor, ly=np$hlowdiff, yhat=c(np$linPredDiff), uy=np$hupdiff)
  
  richout <- fitTib %>% 
    full_join(dat %>% dplyr::select(ti_orig,  "new_cases"), by="ti_orig") %>% 
    merge(horTib, by = "ti_orig", all.y = T) %>% 
    set_colnames(value = c("x1", "pc", "pc_all", "ly", "y", "uy"))
  
  parsout <- list()
  parsout[[1]] <- np$pars
  parsout[[2]] <- np$hubasyVar
  
  return(list(np, richout, parsout))
}

get_CI <- function(parsout){
  # CI r
  low_r <- parsout[[1]][1] - qnorm(.975)*sqrt(parsout[[2]][1,1])
  up_r <- parsout[[1]][1] + qnorm(.975)*sqrt(parsout[[2]][1,1])
  
  # CI h
  low_h <- parsout[[1]][2] - qnorm(.975)*sqrt(parsout[[2]][2,2])
  up_h <- parsout[[1]][2] + qnorm(.975)*sqrt(parsout[[2]][2,2])
  
  # CI p
  low_p <- parsout[[1]][3] - qnorm(.975)*sqrt(parsout[[2]][3,3])
  up_p <- parsout[[1]][3] + qnorm(.975)*sqrt(parsout[[2]][3,3])
  
  # CI b
  low_s <- parsout[[1]][4] - qnorm(.975)*sqrt(parsout[[2]][4,4])
  up_s <- parsout[[1]][4] + qnorm(.975)*sqrt(parsout[[2]][4,4])
  
  # CI b
  low_b <- parsout[[1]][5] - qnorm(.975)*sqrt(parsout[[2]][5,5])
  up_b <- parsout[[1]][5] + qnorm(.975)*sqrt(parsout[[2]][5,5])
  
  
  oo <- cbind("r" = paste0(round(exp(parsout[[1]][1]),4), " (",paste0(round(exp(c(low_r, up_r)),4),collapse = ", "), ")"),
              "h" = paste0(round(exp(parsout[[1]][2]),4), " (",paste0(round(exp(c(low_h, up_h)),4),collapse = ", "), ")"),
              "p" = paste0(round(parsout[[1]][3],4), " (",paste0(round(c(low_p, up_p),4),collapse = ", "), ")"),
              "s" = paste0(round(parsout[[1]][4],4), " (",paste0(round(c(low_s, up_s),4),collapse = ", "), ")"),
              "b" = paste0(round(exp(parsout[[1]][5]),4), " (",paste0(round(exp(c(low_b, up_b)),4),collapse = ", "), ")"))
  return(oo)
}


# Model -------------------------------------------------------------------

############# VENETO #############
# 2022
veneto_2022 <- data_model[[which(regY$name_region == "Veneto" & regY$Y == 2022)]] %>% filter(ti_orig<="2022-09-20")

c(np, richout, parsout) %<-% fit_richards(dat = veneto_2022, fam = "Poisson", off = 4847147/1000, horizon = 3)

veneto_2022_last <- data_model[[which(regY$name_region == "Veneto" & regY$Y == 2022)]]  %>% 
  filter(ti_orig %in% richout$x1[(nrow(veneto_2022)+1):(nrow(veneto_2022)+3)]) 

ggplot() +
  geom_point(data = richout, aes(x = x1, y = pc), size = 4) +
  geom_point(data = veneto_2022_last, aes(x = ti_orig, y = new_cases), size = 4, shape = 18, color = "red") +
  geom_line(data = richout, aes(x = x1, y = y), color = "red", linewidth = 1.01) +
  geom_ribbon(data = richout, aes(x = x1, ymin = ly, ymax = uy), alpha = .4, fill = I("salmon")) +
  labs(x = "", y = "West nile cases") +
  theme_bw() +
  theme(text = element_text(size = 24))

get_CI(parsout = parsout)

np$R2diff
sqrt(mean((richout$y[(nrow(richout)-2):nrow(richout)] - veneto_2022_last$new_cases)^2))


# 2018
veneto_2018 <- data_model[[which(regY$name_region == "Veneto" & regY$Y == 2018)]]

c(np, richout, parsout) %<-% fit_richards(dat = veneto_2018, fam = "Poisson", off = 4905000/1000, horizon = 0)

ggplot() +
  geom_point(data = richout, aes(x = x1, y = pc), size = 4) +
  geom_line(data = richout, aes(x = x1, y = y), color = "red", linewidth = 1.01) +
  geom_ribbon(data = richout, aes(x = x1, ymin = ly, ymax = uy), alpha = .4, fill = I("salmon")) +
  labs(x = "", y = "West nile cases") +
  theme_bw() +
  theme(text = element_text(size = 24))

get_CI(parsout = parsout)


############# EMILIA-ROMAGNA #############
# 2018
ER_2018 <- data_model[[which(regY$name_region == "Emilia-Romagna" & regY$Y == 2018)]]

c(np, richout, parsout) %<-% fit_richards(dat = ER_2018, fam = "Poisson", off = 4453000/1000)

ggplot() +
  geom_point(data = richout, aes(x = x1, y = pc), size = 4) +
  geom_line(data = richout, aes(x = x1, y = y), color = "red", linewidth = 1.01) +
  geom_ribbon(data = richout, aes(x = x1, ymin = ly, ymax = uy), alpha = .4, fill = I("salmon")) +
  labs(x = "", y = "West nile cases") +
  theme_bw() +
  theme(text = element_text(size = 24))

get_CI(parsout = parsout)

# 2022
ER_2022 <- data_model[[which(regY$name_region == "Emilia-Romagna" & regY$Y == 2022)]] %>% filter(ti_orig<="2022-09-20")

c(np, richout, parsout) %<-% fit_richards(dat = ER_2022, fam = "Poisson", off = 4458006/1000, horizon = 3)

ER_2022_last <- data_model[[which(regY$name_region == "Emilia-Romagna" & regY$Y == 2022)]]  %>% 
  filter(ti_orig %in% richout$x1[(nrow(ER_2022)+1):(nrow(ER_2022)+3)]) 

ggplot() +
  geom_point(data = richout, aes(x = x1, y = pc), size = 4) +
  geom_point(data = ER_2022_last, aes(x = ti_orig, y = new_cases), size = 4, shape = 18, color = "red") +
  geom_line(data = richout, aes(x = x1, y = y), color = "red", linewidth = 1.01) +
  geom_ribbon(data = richout, aes(x = x1, ymin = ly, ymax = uy), alpha = .4, fill = I("salmon")) +
  labs(x = "", y = "West nile cases") +
  theme_bw() +
  theme(text = element_text(size = 24))

get_CI(parsout = parsout)