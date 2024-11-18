#PLANS FOR GRAPH

#1945 - 1954 End of WWII, Chinese Civil War, Korean War, First Indo-China War
#1953 - 1959 Cuban Revolution
#1955-1975 Vietnam War
#1979-1989 Soviet-Afghan War, Lebanese Civil War, Iran-Iraq War

#the current maps show dots, but for event, but some events overlap, so I should group by region and then have fill be by number of events

library(tidyverse)
library(ggplot2)
library(plotly)
library(leaflet)


globe <- map_data("world")

major_events <- read.csv("Major Events.csv")
explosions <- read.csv("nuclear_explosions.csv")

explosion_event <- major_events %>%
  full_join(explosions, by = "year")

explosions_1945_1954 <- explosion_event %>%
  filter(year <= 1954) %>%
  filter(!is.na(region))

counts_1945_1954 <- explosions_1945_1954 %>%
  summarize(n=n()) %>%
  mutate("Period" = "1945-1954")

ggplot() +
  geom_map(data = globe, map = globe,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "#7f7f7f", size=0.5) +
  geom_point(data = explosions_1945_1954, aes(x = longitude, y = latitude),        
             shape = 'circle', fill = 'black',
             color = 'black', stroke = 0.5)



explosions_1953_1959 <- explosion_event %>%
  filter(year >= 1953 & year <=1959) %>%
  filter(!is.na(region))


counts_1953_1959 <- explosions_1953_1959 %>%
  summarize(n=n()) %>%
  mutate("Period" = "1953-1959")

ggplot() +
  geom_map(data = globe, map = globe,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "#7f7f7f", size=0.5) +
  geom_point(data = explosions_1953_1959, aes(x = longitude, y = latitude),        
             shape = 'circle', fill = 'black',
             color = 'black', stroke = 0.5)


explosions_1955_1975 <- explosion_event %>%
  filter(year >= 1955 & year <=1975) %>%
  filter(!is.na(region))

counts_1955_1975 <- explosions_1955_1975 %>%
  summarize(n=n()) %>%
  mutate("Period" = "1955-1975")

ggplot() +
  geom_map(data = globe, map = globe,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "#7f7f7f", size=0.5) +
  geom_point(data = explosions_1955_1975, aes(x = longitude, y = latitude),        
             shape = 'circle', fill = 'black',
             color = 'black', stroke = 0.5)

explosions_1979_1989 <- explosion_event %>%
  filter(year >= 1979 & year <=1989) %>%
  filter(!is.na(region))

counts_1979_1989 <- explosions_1979_1989 %>%
  summarize(n=n()) %>%
  mutate("Period" = "1979-1989")

ggplot() +
  geom_map(data = globe, map = globe,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "#7f7f7f", size=0.5) +
  geom_point(data = explosions_1979_1989, aes(x = longitude, y = latitude),        
             shape = 'circle', fill = 'black',
             color = 'black', stroke = 0.5)

counts <- list(counts_1945_1954, counts_1953_1959, counts_1955_1975, counts_1979_1989)
bombs_per_event <- Reduce(function(x, y) merge(x, y, all=TRUE), counts)

ggplot(data = bombs_per_event, aes(x=Period, y=n)) +
  geom_col()

#not that exciting, what if we look by year and country instead?
counts_by_year <- explosion_event %>%
  filter(!is.na(region)) %>%
  group_by(year, country) %>%
  summarize(n=n()) %>%
  mutate(year=as.numeric(year))

ggplot(data=counts_by_year, aes (x= year, y = n, color = country)) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = seq(1945, 1954, 1), limits = c(1945, 1954)) +
  scale_y_continuous(limits = c(0, 20), breaks = seq(0, 20, 2))

ggplot(data=counts_by_year, aes (x= year, y = n, color = country)) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = seq(1953, 1959, 1), limits = c(1953, 1959)) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 10))

ggplot(data=counts_by_year, aes (x= year, y = n, color = country)) +
  geom_jitter(size = 3) +
  scale_x_continuous(breaks = seq(1955, 1975, 1), limits = c(1955, 1975)) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 10))

ggplot(data=counts_by_year, aes (x= year, y = n, color = country)) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = seq(1979, 1989, 1), limits = c(1979, 1989)) +
  scale_y_continuous(limits = c(0, 40), breaks = seq(0, 40, 4))


