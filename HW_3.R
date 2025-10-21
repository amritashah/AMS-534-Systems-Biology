# Homework 3
library(dplyr)
library(ggplot2)

##### 1.
grades <- round(rnorm(n=200, mean=68, sd=10),0)
grades
curvedgrades <- grades + 7
curvedgrades
df = as_tibble(curvedgrades)
df
df %>% summarize(stdev=sd(curvedgrades), minimum=min(curvedgrades), maximum=max(curvedgrades), mean=mean(curvedgrades))
gg <- ggplot(df, aes(x=value)) + geom_histogram(bins=10)
plot(gg)

##### 2.
gorillavsize = read.table('gorilla_sizes.txt', header=TRUE)
gorillavsize <- gorillavsize %>% mutate(sex = if_else(startsWith(specimen, '_0'), 'F', 'M'))
table(gorillavsize$sex)
gorillavsize$log_skull <- log(gorillavsize$skull)
ggp <- ggplot(gorillavsize, aes(x=skull, y=log_skull))
ggp <- ggp + geom_point()
plot(ggp)
big <- gorillavsize %>% filter(skull>250)
big
small <- gorillavsize %>% filter(skull<250)
small

##### 3.
library(nycflights13)
flights2 <- flights %>% select(year:day, hour, flight, origin,dest,tailnum,carrier, dep_delay) %>% left_join(weather) %>% na.omit(dep_delay, temp:visib)
flights2
plot(flights2$temp, flights2$dep_delay)
cor(flights2$temp, flights2$dep_delay)
plot(flights2$wind_speed, flights2$dep_delay)
cor(flights2$wind_speed, flights2$dep_delay)
plot(flights2$wind_gust, flights2$dep_delay)
cor(flights2$wind_gust, flights2$dep_delay)
plot(flights2$precip, flights2$dep_delay)
cor(flights2$precip, flights2$dep_delay)
plot(flights2$visib, flights2$dep_delay)
cor(flights2$visib, flights2$dep_delay)
plot(flights2$pressure, flights2$dep_delay)
cor(flights2$pressure, flights2$dep_delay)

flights3 <- flights2 %>% filter(year==2013, month==6, day==13)
flights3
library(maps)
delayed_airports <- flights3 %>% group_by(dest) %>% summarize(total_flights = n(), total_delays = sum(dep_delay)) %>% 
  filter(total_flights>=1, total_delays>=1)
delayed_airports <- delayed_airports %>% left_join(airports,c('dest'='faa'))
delayed_airports

us_map <- map_data('usa')
flight_map <- ggplot(delayed_airports, aes(x=lon, y=lat)) + 
  geom_polygon(data=us_map, aes(x=long, y=lat, group=group)) +
  geom_point(aes(size=total_delays), color='red') 
plot(flight_map)
