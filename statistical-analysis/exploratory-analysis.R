# Packages
require(tidyverse)
require(magrittr)
require(lubridate)

# Prepare links to read from github repo
yrs <- 2012:2022
hosts <- c("umana", "equidi", "uccelli-bersaglio", "uccelli-selvatici", "entomologica")
yrs_host <- expand_grid(yrs, hosts)
yrs_host %<>% filter(!(hosts %in% c("equidi", "uccelli-bersaglio", "uccelli-selvatici", "entomologica") & yrs < 2017)) %>% arrange(hosts, yrs)
yrs_host$hosts[grep("uccelli", yrs_host$hosts)] <- "uccelli"
fls_umana <- paste0("/wn-ita-province-sorveglianza-umana-", yrs, ".csv")
fls_birds1 <- paste0("/dati-sorveglianza-uccelli-bersaglio/wn-ita-sorveglianza-uccelli-bersaglio-", 2017:2022, ".csv")
fls_birds2 <- paste0("/dati-sorveglianza-uccelli-selvatici/wn-ita-sorveglianza-uccelli-selvatici-", 2017:2022, ".csv")
fls_equids <- paste0("/wn-ita-sorveglianza-equidi-", 2017:2022, ".csv")
fls_ento <- paste0("/wn-ita-sorveglianza-entomologica-", 2017:2022, ".csv")

links <- paste0("https://raw.githubusercontent.com/fbranda/west-nile/main/", yrs_host$yrs, "/dati-sorveglianza-", yrs_host$hosts,
                c(fls_ento, fls_equids, fls_birds1, fls_birds2, fls_umana))

# Read data
# Human
dat_wn_umana <- map_dfr(links[grep("umana", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), nuovi_casi = as.numeric(nuovi_casi)) })

# Equids
dat_wn_equids <- map_dfr(links[grep("equid", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% 
                            mutate(data = date(data), nuovi_casi = as.numeric(nuovi_casi)) %>% 
                            select(data:nuovi_casi)})

# Mosquito
dat_wn_ento <- map_dfr(links[grep("entomo", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), nuovi_casi = as.numeric(nuovi_casi)) })

# Birds 1
dat_wn_birds1 <- map_dfr(links[grep("bersaglio", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), nuovi_casi = as.numeric(nuovi_casi)) })

# Human
dat_wn_birds2 <- map_dfr(links[grep("selvatici", links)], 
                        function(x){ as_tibble(data.table::fread(x)) %>% mutate(data = date(data), nuovi_casi = as.numeric(nuovi_casi)) })

dat_wn_birds <- bind_rows(
  dat_wn_birds1 %>% select(data, denominazione_regione, denominazione_provincia, specie, nuovi_casi),
  dat_wn_birds2 %>% select(data, denominazione_regione, denominazione_provincia, specie, nuovi_casi)
)

all_reg <- base::union(base::union(unique(dat_wn_birds$denominazione_regione), unique(dat_wn_equids$denominazione_regione)), 
                 unique(dat_wn_ento$denominazione_regione)) %>% sort
# EDA ---------------------------------------------------------------------
# Tot cases
sum(dat_wn_umana$nuovi_casi, na.rm = T)
# Yearly rate
sum(dat_wn_umana$nuovi_casi, na.rm = T)/11

# Yearly totals
dat_wn_umana %>% group_by(Y = year(data)) %>% summarise(Tot = sum(nuovi_casi, na.rm = T)) %>% arrange(Tot)

# Yearly rate no 2018 and 2022
sum(dat_wn_umana$nuovi_casi[!(year(dat_wn_umana$data) %in% c(2018, 2022))], na.rm = T)/9

# By region and province
dat_wn_umana %>% 
  group_by(denominazione_regione, denominazione_provincia) %>% 
  summarise(Tot = sum(nuovi_casi, na.rm = T)) %>% 
  group_by(denominazione_regione) %>% 
  mutate(TotR = sum(Tot), Perc = Tot/TotR) %>% 
  arrange(desc(TotR))

#### Figure 3a ####
dat_wn_umana %>% 
  group_by(M = month(data), Y = year(data)) %>% 
  summarise(data = last(data), Tot = sum(nuovi_casi, na.rm = T)) %>% 
  ggplot(aes(x = data, xend = data, y = 0, yend = Tot)) + 
  geom_segment() +
  labs(x = "", y = "Monthly WN infections") +
  scale_x_date(breaks = "year", date_labels = "%Y") +
  theme_bw() +
  theme(text = element_text(size = 16))

#### Figure 3b ####
dat_wn_umana %>% 
  group_by(Y = year(data), eta) %>% 
  summarise(Tot = sum(nuovi_casi, na.rm = T)) %>% ungroup() %>% 
  filter(eta != "NA") %>% 
  mutate(eta = factor(eta, levels = c("<=14", "15-44", "45-64", "65-74", ">=75"))) %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = eta, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "Age class") +
  scale_fill_manual(values = c("tomato", "salmon", "orange", "gold", "skyblue3")) +
  scale_x_continuous(breaks = 2012:2022, labels = 2012:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))


#### Figure 4a ####
dat_wn_ento %>% mutate(denominazione_regione = factor(denominazione_regione, levels = all_reg)) %>% 
  group_by(Y = year(data), denominazione_regione) %>% 
  summarise(Tot = sum(nuovi_casi, na.rm = T)) %>% ungroup() %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = denominazione_regione, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "") +
  scale_fill_manual(values = c("tomato", "salmon", "orange", 
                               "gold", "skyblue3", "violet", "purple")) +
  scale_x_continuous(breaks = 2017:2022, labels = 2017:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))

#### Figure 4b ####
dat_wn_equids %>% mutate(denominazione_regione = factor(denominazione_regione, levels = all_reg)) %>% 
  group_by(Y = year(data), denominazione_regione) %>% 
  summarise(Tot = sum(nuovi_casi, na.rm = T)) %>% ungroup() %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = denominazione_regione, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "") +
  scale_fill_manual(values = c("brown", "red", "tomato", "salmon", "darkorange", "orange", 
                               "gold", "lightblue", "skyblue3", "cyan", "violet", "purple")) +
  scale_x_continuous(breaks = 2017:2022, labels = 2017:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))

#### Figure 4c ####
dat_wn_birds %>% mutate(denominazione_regione = factor(denominazione_regione, levels = all_reg)) %>% 
  group_by(Y = year(data), denominazione_regione) %>% 
  summarise(Tot = sum(nuovi_casi, na.rm = T)) %>% ungroup() %>% 
  group_by(Y) %>% 
  mutate(TotY = sum(Tot), Perc = Tot/TotY) %>% 
  ggplot(aes(x = Y, y = Perc, fill = denominazione_regione, color = I("black"))) +
  geom_bar(stat = "identity") +
  labs(x = "", y = "New cases composition", fill = "") +
  scale_fill_manual(values = c("tomato", "salmon", "orange", "gold", "skyblue3", "purple")) +
  scale_x_continuous(breaks = 2017:2022, labels = 2017:2022, expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(size = 16))
