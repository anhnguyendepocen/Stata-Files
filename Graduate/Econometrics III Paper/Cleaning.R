############################## Packages ##############################

# Data download:
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/11180

rm(list=ls())
library(dplyr)
library(foreign)
setwd("U:/706 Project/Stata Data")

############################## 1993 Data ##############################

# age, gender, yrseduc
datam <- read.dta("m8_hrost .dta")
datam <- datam %>% group_by(hhid) %>% 
  mutate(hhsize_0_1 = sum(age>=0 & age<=1 & mcode==1),
         hhsize_2_5 = sum(age>=2 & age<=5 & mcode==1))
datam <- filter(datam, pcode==1)
datam <- select(datam, hhid, age, gender, yrseduc,
                hhsize_0_1, hhsize_2_5)

# hhsize, mxhea, mxinsur
datam1 <- read.dta("HHEXPTL.dta")
datam1 <- select(datam1, hhid, hhsizem, mxhea, mxinsur)
datam <- left_join(datam, datam1, by=c("hhid"="hhid"))
datam$hhsizem <- datam$hhsizem - datam$hhsize_0_1 - datam$hhsize_2_5

# race
datam1 <- read.dta("s4_h def.dta")
datam1 <- select(datam1, hhid, race)
datam <- left_join(datam, datam1, by=c("hhid"="hhid"))

# totminc
datam1 <- read.dta("HHINCTL.dta")
datam1 <- select(datam1, hhid, totminc)
datam <- left_join(datam, datam1, by=c("hhid"="hhid"))

# mxcig, mxalc
datam1 <- read.dta("NF1X01.dta")
datam1 <- select(datam1, hhid, mxcig, mxalc)
datam <- left_join(datam, datam1, by=c("hhid"="hhid"))

# yxtrad
datam1 <- read.dta("NF2X02.dta")
datam1 <- select(datam1, hhid, yxtrad)
datam <- left_join(datam, datam1, by=c("hhid"="hhid"))
rm(datam1)

############################## 1998 Data ##############################

# age, gender, yrseduc
# corrects for dead household heads
datan <- read.dta("rost er.dta")
datan <- datan %>% group_by(hhid) %>% 
  mutate(hhsize_0_1 = sum(age>=0 & age<=1 & nonmem==0),
         hhsize_2_5 = sum(age>=2 & age<=5 & nonmem==0))
datan <- filter(datan, pcode==1|head==1)
datan <- datan %>% group_by(hhid) %>% 
  mutate(age = ifelse(yrdeath!=-1, -1, age),
         gender = ifelse(yrdeath!=-1, -1, gender),
         yrseduc = ifelse(yrdeath!=-1, -1, yrseduc))
datan <- datan %>% group_by(hhid) %>% 
  summarise(age = max(age), gender=max(gender), yrseduc=max(yrseduc),
            hhsize_0_1 = max(hhsize_0_1), hhsize_2_5 = max(hhsize_2_5))

datan1 <- read.dta("hh size98.dta")
datan1 <- select(datan1, hhid, hhsizem, race)
datan <- left_join(datan, datan1, by=c("hhid"="hhid"))
datam$hhsizem <- datam$hhsizem - datam$hhsize_0_1 - datam$hhsize_2_5

# mxhea and mxinsure
datan1 <- read.dta("exp end98.dta")
datan1 <- select(datan1, hhid, mxhea, mxinsure)
datan <- left_join(datan, datan1, by=c("hhid"="hhid"))

# totminc
datan1 <- read.dta("inco me98.dta")
datan1 <- select(datan1, hhid, totminc)
datan <- left_join(datan, datan1, by=c("hhid"="hhid"))

# mxcig, mxalc
datan1 <- read.dta("nf1 x01.dta")
datan1 <- select(datan1, hhid, mxcig, mxalc)
datan <- left_join(datan, datan1, by=c("hhid"="hhid"))

# yxtrad
datan1 <- read.dta("nf2 x02.dta")
datan1 <- select(datan1, hhid, yxtrad)
datan <- left_join(datan, datan1, by=c("hhid"="hhid"))

# births
datan1 <- read.dta("pre g.dta")
table(datan1$numaliv5)
datan1 <- datan1 %>%
  mutate(numaliv5 = ifelse(numaliv5<0, 0, numaliv5))
datan1 <- datan1 %>% group_by(hhid) %>%
  summarize(births = sum(numaliv5))
datan <- left_join(datan, datan1, by=c("hhid"="hhid"))
rm(datan1)

############################## Stacking Panels ##############################

datam$births = 0
datam$year = 1993
datan$year = 1998
names(datan)[names(datan)=="mxinsure"] <- "mxinsur"
mydata <- bind_rows(datam, datan)
rm(datam)
rm(datan)
mydata <- mydata %>%
  filter(totminc>0 & hhsizem>0)
mydata <- mydata[order(mydata$hhid,mydata$year),]
mydata <- mydata %>% group_by(hhid,year) %>%
  filter(n()==1)
mydata <- mydata %>% group_by(hhid) %>%
  filter(n()==2)
mydata <- mydata %>%
  mutate(births = if_else(is.na(births), 0, births))
mydata <- mydata %>%
  mutate(one_birth = 1*(births==1),
         two_births = 1*(births==2),
         three_plus = 1*(births>=3))
setwd("U:/706 Project")
write.dta(mydata, "mydata.dta")