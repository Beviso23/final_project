library(tidyverse)
library(vistime)
library(ggplot2)
library(leaflet)
library(ggthemes)
library(ggpubr)

globe <- map_data("world")

major_events <- read.csv("Major Events.csv")
explosions <- read.csv("nuclear_explosions.csv")

explosion_event <- major_events %>%
  full_join(explosions, by = "year")

explosions_1945_1954 <- explosion_event %>%
  filter(year <= 1954) %>%
  filter(!is.na(region)) %>%
  left_join(region_1945_1954, by='region')

region_1945_1954 <- explosions_1945_1954 %>%
  group_by(region) %>%
  summarize(count=n())

explosions_1953_1959 <- explosion_event %>%
  filter(year >= 1953 & year <=1959) %>%
  filter(!is.na(region)) %>%
  left_join(region_1953_1959, by='region')

region_1953_1959 <- explosions_1953_1959 %>%
  group_by(region) %>%
  summarize(count=n())

explosions_1955_1975 <- explosion_event %>%
  filter(year >= 1955 & year <=1975) %>%
  filter(!is.na(region)) %>%
  left_join(region_1955_1975, by='region')

region_1955_1975 <- explosions_1955_1975 %>%
  group_by(region) %>%
  summarize(count=n())

explosions_1979_1989 <- explosion_event %>%
  filter(year >= 1979 & year <=1989) %>%
  filter(!is.na(region))%>%
  left_join(region_1979_1989, by='region')

region_1979_1989 <- explosions_1979_1989 %>%
  group_by(region) %>%
  summarize(count=n())

pal1<- leaflet::colorNumeric("viridis", domain = explosions_1945_1954$count)
pal2<- leaflet::colorNumeric("viridis", domain = explosions_1953_1959$count)
pal3<- leaflet::colorNumeric("viridis", domain = explosions_1955_1975$count)
pal4<- leaflet::colorNumeric("viridis", domain = explosions_1979_1989$count)

leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = explosions_1945_1954, ~longitude, ~latitude , color = ~pal1(count), fillOpacity = 0.7,group = "1945-1954")%>%
  addLegend(data = explosions_1945_1954,
            position = "bottomright",
            pal = pal1, values = ~count,
            title = "Legend",
            opacity = 1, group="1945-1954") %>%
  addCircleMarkers(data = explosions_1953_1959, ~longitude, ~latitude , color = ~pal2(count), fillOpacity = 0.7,group = "1953-1959")%>%
  addLegend(data = explosions_1953_1959,
            position = "bottomright",
            pal = pal2, values = ~count,
            title = "Legend",
            opacity = 1, group="1953-1959") %>%
  addCircleMarkers(data = explosions_1955_1975, ~longitude, ~latitude , color = ~pal3(count), fillOpacity = 0.7,group = "1955-1975")%>%
  addLegend(data = explosions_1955_1975,
            position = "bottomright",
            pal = pal3, values = ~count,
            title = "Legend",
            opacity = 1, group = "1955-1975") %>%
  addCircleMarkers(data = explosions_1979_1989, ~longitude, ~latitude , color = ~pal4(count), fillOpacity = 0.7,group = "1979-1989")%>%
  addLegend(data = explosions_1979_1989,
            position = "bottomright",
            pal = pal4, values = ~count,
            title = "Legend",
            opacity = 1, group = "1979-1989") %>%
  addLayersControl(overlayGroups = c("1945-1954", "1953-1959", "1955-1975", "1979-1989"), position = "topright", options = layersControlOptions(collapsed = F))


#looking at trend of each country from 1945 to 1998
counts_by_year <- explosion_event %>%
  filter(!is.na(region)) %>%
  group_by(year, country) %>%
  summarize(n=n()) %>%
  mutate(year=as.numeric(year))

PAK_events <- counts_by_year %>%
  filter(country == "PAKIST")

#calplot, series of rectangles of different lengths with text saying what the event is
#use geom_rect or geom_polygon, something like that

nukes_by_year <- ggplot(data=counts_by_year, aes (x= year, y = n, color=country)) +
  geom_line(linewidth=1) +
  geom_point(data = PAK_events, color="orange") +
  theme_bw() +
  scale_x_continuous(breaks = seq(1945, 2000, 5), limits = c(1945, 1998)) +
  scale_color_manual(breaks = c("CHINA", "FRANCE", "INDIA", "PAKIST", "UK", "USA", "USSR"), values=c("hotpink3", "blue", "green3", "orange", "steelblue", "black", "red3"))+
  theme(panel.background=element_blank(),,panel.grid.major=element_blank(),
         panel.grid.minor=element_blank(),plot.background=element_blank()) +
  theme(legend.position="top") +
  guides(colour = guide_legend(nrow = 1))

timeline <- data.frame(Position = rep(c("", "", "", "", "", "", "", "", ""), each = 1),
                   Name = c("World War II", "Chinese Civil War", "First IndoChina War", "Korean War", "Cuban Revolution", "Vietnam War", "Lebanese Civil War", "Soviet-Afghan War", "Iran-Iraq War"),
                   start = c("1945-01-01", "1945-01-01", "1946-01-01", "1951-01-01", "1953-01-01", "1955-01-01", "1975-01-01", "1979-01-01", "1980-01-01" ),
                   end = c("1945-12-31", "1949-12-31", "1954-12-31", "1954-12-31", "1959-12-31", "1975-12-31", "1990-12-31", "1989-12-31", "1988-12-31"),
                   color = c("lightgrey", "azure2", "skyblue", "skyblue2", "steelblue","steelblue4",  "blue",  "blue3", "navy"))

wars<- gg_vistime(timeline, col.event = "Position", col.group = "Name") +
  scale_x_datetime(date_breaks = "5 years", date_labels = "%Y", limits = as.POSIXct(c("1945-01-01", "2000-01-01"))) +
  theme_tufte() +
  theme(axis.text.x=element_blank(), axis.ticks.x = element_blank()) 


ggarrange(nukes_by_year, wars, nrow=2, heights = c(3, 1.5), align = 'v')

?gg_vistime()
