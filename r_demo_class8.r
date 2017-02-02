########################
# R Script for Class 6 #
########################
# based in part on Germán Rodríguez GLM 
# lecture notes and R scripts. 
# Rodríguez, G. (2007). Lecture Notes on Generalized Linear Models. URL: http://data.princeton.edu/wws509/notes/

library(stargazer)
library(lavaan)
library(ggplot2)
library(scatterplot3d)
library(rgl)
library(calibrate)

setwd('~/Dropbox/upf_global_studies/2017/slides/global_studies_research_methods/images')

fpe <- read.table("http://data.princeton.edu/wws509/datasets/effort.dat")

p = ggplot(fpe, aes(x = setting, y = change))
p + geom_point()
p + geom_point() + geom_smooth(method = "lm", se = TRUE)


pairs(fpe)

M = lm(change~setting+effort, data=fpe)
summary(M)

stargazer(M, type="html")

newdat <- expand.grid(effort=seq(0,35,by=.5),setting=seq(30,90,by=.5))
newdat$change = predict(M, newdata=newdat)
with(fpe,plot3d(effort,setting,change, col="blue", size=1, type="s"))
with(newdat,surface3d(unique(effort),unique(setting),change,alpha=0.3,front="line", back="line"))
writeWebGL(dir="fp_3Dreg", width=1000)

fpe.g = fpe

fpe.g$effort <- cut(fpe$effort, breaks=c(min(fpe$effort),5,15,max(fpe$effort)), right=FALSE, include.lowest=TRUE, labels=c("Weak","Moderate","Strong"))

M2 = lm(change~setting+effort, data=fpe.g)
summary(M2)
M2l = data.frame(intercept = coef(M2)[1], slope=coef(M2)[2], effort = "Weak")
M2m = data.frame(intercept = (coef(M2)[1]+coef(M2)[3]), slope=coef(M2)[2], effort="Moderate")
M2s = data.frame(intercept = (coef(M2)[1]+coef(M2)[4]), slope=coef(M2)[2], effort = "Strong")
M2r = rbind(M2l, M2m, M2s)
  
stargazer(M2, type="html")

p = ggplot(fpe.g, aes(x = setting, y = change))
p + geom_point(aes(colour=effort))
ggsave("fp_reg_cat.png")

p = ggplot(fpe.g, aes(x = setting, y = change))
p + geom_point(aes(colour=effort)) + geom_abline(aes(intercept=intercept, slope=slope, colour=effort), data=M2r) + guides(colour=guide_legend("effort"))
ggsave("fp_reg_ints.png")

M3 = lm(change~setting+effort+setting*effort, data=fpe.g)
summary(M3)
M3l = data.frame(intercept = coef(M3)[1], slope=coef(M3)[2], effort = "Weak")
M3m = data.frame(intercept = (coef(M3)[1]+coef(M3)[3]), slope=(coef(M3)[2]+coef(M3)[5]), effort="Moderate")
M3s = data.frame(intercept = (coef(M3)[1]+coef(M3)[4]), slope=(coef(M3)[2]+coef(M3)[6]), effort = "Strong")
M3r = rbind(M3l, M3m, M3s)

stargazer(M3, type="html")

p = ggplot(fpe.g, aes(x = setting, y = change))
p + geom_point(aes(colour=effort)) + geom_abline(aes(intercept=intercept, slope=slope, colour=effort), data=M3r) + guides(colour=guide_legend("effort"))
ggsave("fp_reg_ints_slopes.png")


M3 = lm(change~setting+effort+setting*effort, data=fpe)
summary(M3)

stargazer(M3, type="html")

p = ggplot(fpe.g, aes(x = setting, y = change))
p + geom_point(aes(colour=effort)) + geom_abline(aes(intercept=intercept, slope=slope, colour=effort), data=M3r) + guides(colour=guide_legend("effort")) 
ggsave("fp_reg_ints_slopes.png")

newdat <- expand.grid(effort=seq(0,35,by=.5),setting=seq(30,90,by=.5))
newdat$change = predict(M3, newdata=newdat)
with(fpe,plot3d(effort,setting,change, col="blue", size=1, type="s"))
with(newdat,surface3d(unique(effort),unique(setting),change,alpha=0.3,front="line", back="line"))
writeWebGL(dir="fp_int_3Dreg", width=1000)


fpe$setting_sq = fpe$setting^2

M4 = lm(change~setting + setting_sq, data=fpe)
summary(M4)
stargazer(M4, type="html")

M40 = lm(change~setting, data=fpe)
summary(M40)
stargazer(M40, M4, type="html")



p = ggplot(fpe, aes(x = setting, y = change))
p + geom_point() + stat_smooth(method="lm", se=TRUE, fill="grey", formula=y ~ poly(x, 2, raw=TRUE))
ggsave("fp_reg_quad.png")


fpe$high_change = fpe$change > 20
p = ggplot(fpe, aes(x = setting, y = high_change))
p + geom_point()

glm(high_change~setting, data=fpe, family = binomial(link=logit))

p + geom_point() + geom_abline(aes(intercept=intercept, slope=slope, colour=effort), data=M3r) + guides(colour=guide_legend("effort")) 
ggsave("fp_reg_ints_slopes.png")



