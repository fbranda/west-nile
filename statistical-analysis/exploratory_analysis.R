###################################################################################################
########## Overview of WNV infections in the Italian territory over the period 2012-2022 ##########
###################################################################################################

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
dat_wn_umana <- map_dfr(links[grep("human", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

# Equids
dat_wn_equids <- map_dfr(links[grep("equid", links)], 
                         function(x){ as_tibble(data.table::fread(x)) %>% 
                             mutate(data = date(data), new_cases = as.numeric(new_cases)) %>% 
                             select(data:new_cases)})

# Mosquito
dat_wn_ento <- map_dfr(links[grep("mosqui", links)], 
                       function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

# Birds 1
dat_wn_birds1 <- map_dfr(links[grep("target", links)], 
                         function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

# Human
dat_wn_birds2 <- map_dfr(links[grep("wild", links)], 
                         function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), new_cases = as.numeric(new_cases)) })

dat_wn_birds <- bind_rows(
  dat_wn_birds1 %>% select(data, name_region, name_province, species, new_cases),
  dat_wn_birds2 %>% select(data, name_region, name_province, species, new_cases)
)

all_reg <- base::union(base::union(unique(dat_wn_birds$name_region), unique(dat_wn_equids$name_region)), 
                       unique(dat_wn_ento$name_region)) %>% sort
# EDA ---------------------------------------------------------------------
# Tot cases
sum(dat_wn_umana$new_cases, na.rm = T)
# Yearly rate
sum(dat_wn_umana$new_cases, na.rm = T)/11

# Yearly totals
dat_wn_umana %>% group_by(Y = year(data)) %>% summarise(Tot = sum(new_cases, na.rm = T)) %>% arrange(Tot)

# Yearly rate no 2018 and 2022
sum(dat_wn_umana$new_cases[!(year(dat_wn_umana$data) %in% c(2018, 2022))], na.rm = T)/9

# By region and province
dat_wn_umana %>% 
  group_by(name_region, name_province) %>% 
  summarise(Tot = sum(new_cases, na.rm = T)) %>% 
  group_by(name_region) %>% 
  mutate(TotR = sum(Tot), Perc = Tot/TotR) %>% 
  arrange(desc(TotR))

#### Figure 3a ####
dat_wn_umana %>% 
  group_by(M = month(data), Y = year(data)) %>% 
  summarise(data = last(data), Tot = sum(new_cases, na.rm = T)) %>% 
  ggplot(aes(x = data, xend = data, y = 0, yend = Tot)) + 
  geom_segment() +
  labs(x = "", y = "Monthly WN infections") +
  scale_x_date(breaks = "year", date_labels = "%Y") +
  theme_bw() +
  theme(text = element_text(size = 16))

#### Figure 3b ####
dat_wn_umana %>% 
  group_by(Y = year(data), age) %>% 
  summarise(Tot = sum(new_cases, na.rm = T)) %>% ungroup() %>% 
  filter(age != "NA") %>% 
  mutate(age = factor(age, levels = c("<=14", "15-44", "45-64", "65-74", ">=75"))) %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = age, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "Age class") +
  scale_fill_manual(values = c("tomato", "salmon", "orange", "gold", "skyblue3")) +
  scale_x_continuous(breaks = 2012:2022, labels = 2012:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))


#### Figure 4a ####
dat_wn_ento %>% mutate(name_region = factor(name_region, levels = all_reg)) %>% 
  group_by(Y = year(data), name_region) %>% 
  summarise(Tot = sum(new_cases, na.rm = T)) %>% ungroup() %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = name_region, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "") +
  scale_fill_manual(values = c("tomato", "salmon", "orange", 
                               "gold", "skyblue3", "violet", "purple")) +
  scale_x_continuous(breaks = 2017:2022, labels = 2017:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))

#### Figure 4b ####
dat_wn_equids %>% mutate(name_region = factor(name_region, levels = all_reg)) %>% 
  group_by(Y = year(data), name_region) %>% 
  summarise(Tot = sum(new_cases, na.rm = T)) %>% ungroup() %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = name_region, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "") +
  scale_fill_manual(values = c("brown", "red", "tomato", "salmon", "darkorange", "orange", 
                               "gold", "lightblue", "skyblue3", "cyan", "violet", "purple")) +
  scale_x_continuous(breaks = 2017:2022, labels = 2017:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))

#### Figure 4c ####
dat_wn_birds %>% mutate(name_region = factor(name_region, levels = all_reg)) %>% 
  group_by(Y = year(data), name_region) %>% 
  summarise(Tot = sum(new_cases, na.rm = T)) %>% ungroup() %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = name_region, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "") +
  scale_fill_manual(values = c("tomato", "salmon", "orange", "gold", "skyblue3", "purple")) +
  scale_x_continuous(breaks = 2017:2022, labels = 2017:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))