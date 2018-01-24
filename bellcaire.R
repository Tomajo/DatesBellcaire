#bellcaire
setwd('/home/toni/Projectes/R/Bellcaire')
library(dplyr)
library(data.table)
library(rJava)
library(xlsx)

# començo el 24-4-2017 perque a la agenda del gmail tinc que hi vàrem anar nosaltres.
# Prenc aquest dia com a punt de partida
# Genero una seqüencia de dates entre les dues dates
dd <- seq(as.IDate("2017-04-24"), as.IDate("2022-12-31"), 1)

#calculo el dia de la setmana i paso a data table
dt <- data.table(dia = dd,diasetmana = weekdays(dd))

dt<-filter(dt,diasetmana %in% c('dilluns','diumenge'))

# poso a tots els dies un 1
dt<-mutate(dt, suma=1)

# agrupo per diasetmana i faig una suma acumulativa de manera que les setmanes queden numerades.
dt<-mutate(group_by(dt,diasetmana), index=cumsum(suma))
# faig el modul 3 per repartir els caps de setmana
dt<-mutate(dt, setmana=index%%3)%>%select(dia,diasetmana,setmana)
# cambio l'etiqueta 
dt<-mutate(dt,Toca=case_when(setmana%%3==1~'Toni&Cris',setmana%%3==2~'Marc&Cris',setmana%%3==0~'Foncho&Ana'))
head(dt,15)

dt<-select(dt,dia,diasetmana,Toca)
# %>%filter(dia>'2018-01-01')


tail(dt,10)
write.xlsx(as.data.frame(dt), "bellcaire.xlsx",col.names = TRUE)

