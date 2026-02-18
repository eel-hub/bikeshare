library(ggplot2)
library(readr)
library(ggrepel)
library(dplyr)
library(tidyr)

options(scipen = 999)

bikeShare <- read.csv("data/Bikeshare.csv")

# Hvornår på dagen udlejes cykler hverdag vs weekend
bikeShare %>%
  group_by(hr, workingday) %>%
  summarise(bikers = mean(bikers)) %>%
  ggplot(aes(x = as.numeric(as.character(hr)), 
             y = bikers,
             colour = factor(workingday))) +
  geom_line(linewidth = 1.2) +
  labs(
    title = "Pendler-effekten ses kun på arbejdsdage",
    subtitle = "To peaks på hverdage – ét bredt peak i weekenden",
    x = "Time på dagen",
    y = "Gennemsnitligt antal cykler",
    colour = "Arbejdsdag"
  ) +
  theme_minimal()


# man kunne også se på: 
# Udlejes der flere cykler når temperaturen stiger?
ggplot(bikeShare, aes(x = temp, y = bikers)) +
  geom_point(alpha = 0.1) +
  geom_smooth(se = FALSE, colour = "orange", size = 1.2) +
  labs(
    title = "Flere cykler udlejes når temperaturen stiger",
    subtitle = "Tydelig positiv sammenhæng mellem temperatur og udlejning",
    x = "Normaliseret temperatur",
    y = "Antal cykler",
    caption = "Capital Bikeshare 2011–2012"
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"))

# Sommer vs vinter
ggplot(bikeShare, aes(x = temp, y = bikers, colour = factor(season))) +
  geom_point(alpha = 0.2) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Temperatur driver cykeludlejning – uanset sæson",
    x = "Normaliseret temperatur",
    y = "Antal cykler",
    colour = "Sæson"
  ) +
  theme_minimal()

