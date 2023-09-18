##########################################
########## Techical validation ###########
##########################################

### 29/08/2023
### Marco Mingione (marco.mingione@uniroma3.it)

# Packages
require(tidyverse)
require(magrittr)
require(lubridate)

# Prepare links to read from github repo
yrs <- 2012:2022
hosts <- c("target-birds", "wild-birds", "equids", "human", "mosquito")
yrs_host <- expand_grid(yrs, hosts)
yrs_host %<>% filter(!(hosts %in% c("equids", "target-birds", "wild-birds", "mosquito") & yrs < 2017)) %>% arrange(hosts, yrs)
yrs_host$hosts[grep("target|wild", yrs_host$hosts)] <- "birds"
fls_umana <- paste0("/wn-ita-provinces-human-surveillance-", yrs, ".csv")
fls_umana_reg <- paste0("/wn-ita-regions-human-surveillance-", yrs, ".csv")
fls_birds1 <- paste0("/wn-ita-target-birds-surveillance-", 2017:2022, ".csv")
fls_birds2 <- paste0("/wn-ita-wild-birds-surveillance-", 2017:2022, ".csv")
fls_equids <- paste0("/wn-ita-equids-surveillance-", 2017:2022, ".csv")
fls_ento <- paste0("/wn-ita-mosquito-surveillance-", 2017:2022, ".csv")

links <- paste0("https://raw.githubusercontent.com/fbranda/west-nile/main/", c(yrs_host$yrs, yrs), "/",
                paste0(c(yrs_host$hosts, rep("human", 11)), "-surveillance"),
                c(fls_equids, fls_umana, fls_ento, fls_birds1, fls_birds2, fls_umana_reg))

# Read data
# Human
dat_wn_umana <- map_dfr(links[grep("province", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) }) # province

dat_wn_umana_reg <- map_dfr(links[grep("region", links)], 
                            function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

# Compute totals by region, monitoring week and type of infections, starting from cases at the province level
summ_prov <- dat_wn_umana %>% group_by(data, name_region, type_infection) %>% summarise(TotP = sum(new_cases, na.rm = T)) %>% ungroup()

# Check when aggregated data from the province level do not match the ones at the regional level: MISMATCH ONLY!
dat_wn_umana_reg %>% select(data, name_region, type_infection, new_cases) %>%
  left_join(summ_prov) %>%
  mutate(Check = new_cases == TotP) %>%
  filter(!Check|is.na(Check))

# Check missing
dat_wn_umana %>% filter(is.na(new_cases)) # from the first differences
dat_wn_umana_reg %>% filter(is.na(code_region)) # ok
dat_wn_umana_reg %>% filter(is.na(new_cases)) # from the first differences


# Equids
dat_wn_equids <- map_dfr(links[grep("equid", links)], 
                         function(x){ as_tibble(data.table::fread(x)) %>% 
                             mutate(data = date(data), new_cases = as.numeric(new_cases), new_deaths = as.numeric(new_deaths)) })
summary(dat_wn_equids)
sum(is.na(dat_wn_equids)) # ok
dat_wn_equids %>% filter(is.na(new_cases)) # from first differences

# Mosquito
dat_wn_ento <- map_dfr(links[grep("mosqui", links)], 
                       function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })
summary(dat_wn_ento)
sum(is.na(dat_wn_ento)) # ok
dat_wn_ento %>% filter(is.na(new_cases)) # from first differences

# Birds 1
dat_wn_birds1 <- map_dfr(links[grep("target", links)], 
                         function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

# Birds 2
dat_wn_birds2 <- map_dfr(links[grep("wild", links)], 
                         function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

dat_wn_birds <- bind_rows(dat_wn_birds1, dat_wn_birds2)

summary(dat_wn_birds)
sum(is.na(dat_wn_birds)) # N. of missing
dat_wn_birds %>% filter(is.na(new_cases)) # These comes from the computation of first differences
dat_wn_birds %>% filter(is.na(species)) # Missing species only for 2021 as expected

