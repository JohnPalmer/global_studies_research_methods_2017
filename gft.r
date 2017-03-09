library(data.table)
library(ggplot2)

setwd("~/Dropbox/upf_global_studies/2017/slides/global_studies_research_methods")

gft = fread('gft_spain.csv')

gft$Date = as.Date(gft$Date)

ggplot(data=gft, aes(Date, Spain)) + geom_line() + ylab("Spain Prediction")



gt = fread('mosquito_trend.csv')

class(gt$Week)
gt$Week = as.Date(gt$Week)
names(gt)[2] = "term"

plt = ggplot(data=gt, aes(Week, term)) + geom_line() + ylab('"Mosquito" Searches Worldwide')

ggsave("mosquito_trend.png", plt)

gt = fread('research_methods_trend.csv')

class(gt$Week)
gt$Week = as.Date(gt$Week)
names(gt)[2] = "term"

plt = ggplot(data=gt, aes(Week, term)) + geom_line() + ylab('"Research Methods" Searches Worldwide')

ggsave("research_methods_trend.png", plt)


gt = fread('machine_learning_trend.csv')

class(gt$Week)
gt$Week = as.Date(gt$Week)
names(gt)[2] = "term"

plt = ggplot(data=gt, aes(Week, term)) + geom_line() + ylab('"Machine Learning" Searches Worldwide')

ggsave("machine_learning_trend.png", plt)


gt = fread('correlate-Influenza_like_Illness_CDC_.csv')
names(gt)
names(gt)[1] = "Week"
names(gt)[2] = "ILI"
names(gt)[3] = "infa"
gt$Week = as.Date(gt$Week, format="%m/%d/%y")


plt = ggplot(data=gt) + geom_line(size=1, aes(Week, ILI, color="ILI (CDC)")) + ylab("Normalized Search Activity / ILI Visits") + geom_line(aes(Week, infa, color="'influenza type a'")) + labs(colour="") 

plt = ggplot(data=gt) + geom_point(aes(infa, ILI)) + ylab("ILI (CDC)") + xlab("'influenza type a'")
plt
ggsave("google_correlate_scatter.png", plt)


