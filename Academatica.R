---
title: "Academatica"
output: 
  flexdashboard::flex_dashboard:
    orientation: rows
    vertical_layout: fill
---

```{r setup, include=FALSE}
library(flexdashboard)
library(readr)
library(dplyr)
library(formattable)
library(ggplot2)
library(lubridate)
```

```{r cargar datos}
stats <- read_csv("data/academica_video_stats.csv")
metadata <- read.csv("data/academica_videos_metadata.csv")
videos <- read_csv("data/academatica_videos.csv")
```

Column {data-width=650}
-----------------------------------------------------------------------
##metricas {data-icon=fa-ruler}

## fila 1

###reproducciones

```{r reproducciones}
format_views <- read_csv("data/academica_video_stats.csv")
metadata <- read.csv("data/academica_videos_metadata.csv")
videos <- read_csv("data/academatica_videos.csv")
```



###col 1.2


###col 1.3

## fila 2 

### Likes

```{r}
rlikes <- metricas$total_likes/(metricas$total_likes+metricas$total_likes+metricas$total_dislikes
rlikes <- round(rlikes*100)
gauge(rlikes, min = 0, max 100,
      symbol = "%"
      gaugeSectors(success = c(80,100),
                   warning = c(50,80),
                   danger = c(0,50))
)
```


### Dislikes

```{r}
gauge(100-rlikes, min = 0, max 100,
      symbol = "%"
      gaugeSectors(success = c(80,100),
                   warning = c(50,80),
                   danger = c(0,50))
)
```



##fila 3 

```{r, fig.width=20}
videos %>%
  mutate(year = year(ymd_hms(contentDetails.videoPublishedAt)),
         month = month(ymd_hms(contentDetails.videoPublishedAt)),
         year = as.factor(year),
         month = as.factor(month)
         ) %>%
  group_by(year,month)%>%
  summarise(uploades_videos = n ()) %>%
  gplot(aes( x=month, y=uploades_videos,fill=year) )+
  geom_col(position = "dodge")+
  theme(axis.text.x = element_text(
    angle=90, vjust = 0.5, hjust =1
    
  )
)+
  facet_grid(year)
```




### Chart A

```{r cargar datos}

```

Column {data-width=350}
-----------------------------------------------------------------------

### Chart B

```{r}

```

### Chart C

```{r}

```

