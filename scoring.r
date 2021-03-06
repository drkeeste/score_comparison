#Code For Part One:
install.packages("xlsx")
library("xlsx")
install.packages("readxl")

#Importing data: 
my_data <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, str(data))
ACT <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "F1:F6608", col_type = "numeric")
GPA <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "AR1:AR6608", col_type = "numeric", skip = 0 )
Math.Placement <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "AO1:AO6608", col_type = "numeric", skip = 0 )
F.M <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "B1:B6608", col_type = "text", skip = 0 )
BC <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "I1:I6608", col_type = "numeric", skip = 0 )
AB <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "H1:H6608", col_type = "numeric", skip = 0 )
Algebra <- read_excel("/Users/dianakeester/Documents/Math450Data.xlsx", sheet = 1, col_names = TRUE, range = "AU1:AU6608", col_type = "numeric", skip = 0 )
math <-  (data.frame(ACT, GPA))
math2 <- (data.frame(ACT, Math.Placement))
math3 <- (data.frame(ACT, Math.Placement, F.M))
math4 <-  (data.frame(BC, Math.Placement, F.M))
math5 <- (data.frame(AB, BC, F.M))
math6 <- (data.frame(GPA, F.M))
math7 <-  (data.frame(ACT, Algebra))
str(math3)


my_data.frame <- math[sample(nrow(math), 6607), ]
ggplot(my_data.frame, aes(x=ACT.Math, y=GPA)) + xlim(10, 36) + ylim(1, 4) +   geom_point()

manemy_data.frame2 <- math2[sample(nrow(math2), 6607), ]
ggplot(my_data.frame2, aes(x=Score, y=ACT.Math)) + xlim(1, 30) + ylim(1,36) +   geom_point() + geom_smooth(se=FALSE)

my_data.frame3 <- math3[sample(nrow(math3), 6607), ]
ggplot(my_data.frame3, aes(x=Score, y=ACT.Math, color = Sex)) + xlim(1, 30) + ylim(10,36) +  geom_point(alpha = 0.5)
str(my_data.frame3)

my_data.frame4 <- math4[sample(nrow(math4), 6607), ]
ggplot(my_data.frame4, aes(x=BC, y=Score, color = Sex)) + xlim(1, 5) + ylim(1, 30) +  geom_point(alpha = 0.5)
str(my_data.frame4)

my_data.frame5 <- math5[sample(nrow(math5), 6607), ]
ggplot(my_data.frame5, aes(x=AB, y=BC, color = Sex)) + xlim(1, 5) + ylim(1, 5) +  geom_point(alpha = 0.5)
str(my_data.frame5)

my_data.frame6 <- math6[sample(nrow(math6), 1000), ]
ggplot(my_data.frame6, aes(x=Sex, y=GPA))  + ylim(0, 4) +  geom_point(alpha = 0.5)
str(my_data.frame5)

str(my_data.frame2)
library(ggplot2)
install.packages("ggplot2")
ggplot(, aes(x=GPA, y=ACT)) + xlim(0, 36) + ylim(0, 4)

ggplot(data = math, aes(x=ACT, y=GPA)) + 
  geom_point(aes(colour=ACT))

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width))  +   geom_point()
str(iris)



#Code for Part Four:
ACT <- Dataset[,6] (where Dataset is what I named the data I had imported) 
Placement <- Dataset[,41]
SEX <- Dataset[,2]
data.frame2 <-  (data.frame(ACT, Placement))

newdataframe <- data.frame2[data.frame3$ACT >= 10, ]
dataframe <- na.omit(newdataframe[newdataframe$Placement != 0, ])


fit = lm(Placement ~ ACT, data=dataframe)

pred_interval = cbind("ACT"=dataframe$ACT, predict(fit, dataframe, interval = "prediction", level = 0.95))
colnames(pred_interval)[2]<-paste("Placement")
pred_interval = as.data.frame(pred_interval)

conf_interval = cbind("ACT"=dataframe$ACT, predict(fit, dataframe, interval = "confidence", level = 0.95))
colnames(conf_interval)[2]<-paste("Placement")
conf_interval = as.data.frame(conf_interval)

ggplot(dataframe, aes(x=ACT, y=Placement)) + theme_bw()  + xlim(1, 36)  + geom_point(alpha = 0.5) + geom_smooth(method = "lm", se=TRUE) + geom_ribbon(data=pred_interval, aes(ymin=lwr,ymax=upr), fill="blue",alpha=.1)

ggplot(dataframe, aes(x=ACT,y=Placement)) + theme_bw() + xlim(1, 36) + ylim(1,40) + geom_point() + geom_smooth(method = "lm", se=FALSE) + geom_ribbon(data=pred_interval, aes(ymin=lwr,ymax=upr), fill="blue",alpha=.1) + geom_ribbon(data=conf_interval, aes(ymin=lwr,ymax=upr), fill="blue",alpha=.2)


ggplot(dataframe, aes(x=ACT, y=Placement)) + xlim(1, 5)+ geom_point(alpha = 0.5) + geom_smooth(method = "lm", se=TRUE)



# order rows
pred_interval <- pred_interval[order(pred_interval$ACT),]

# only distict data values
install.packages("dplyr")
library(dplyr)
distinct(pred_interval)
pred_interval <- distinct(pred_interval)

# confidence intervals whole dataframe and one data point
predict(fit, data.frame(dataframe), interval = "prediction", level = 0.95)
predict(fit, data.frame(ACT=14), interval = "confidence", level = 0.95)

# prediction interval for one data point
predict(fit, data.frame(ACT=14), interval = "prediction", level = 0.95)

# plot including gender
ggplot(data.frame2, aes(x=ACT, y=Placement, color = SEX)) + xlim(10, 36) + ylim(1,30) +  geom_point(alpha = 0.5)
fit = lm( Placement ~ ACT, data=dataframe)
ggplot(data.frame2, aes(ACT, Placement, color = SEX)) + xlim(10, 36) + ylim(1,30) + geom_point(alpha = 0.5) + geom_smooth(method = "lm", se=FALSE)

#Code for Project Part 4 Continued:
ggplot(data.frame2, aes(x=sACT,y=sGPA)) + ggtitle("Sports Medicine Majors") + theme_bw() +theme(plot.title = element_text(hjust = 0.5)) + scale_x_continuous(name="ACT", limits=c(17, 36)) +scale_y_continuous(name="GPA", limits=c(0, 5))  + geom_point() + geom_smooth(method = "lm", se=FALSE, colour="green") + geom_ribbon(data=spred_interval, aes(ymin=lwr,ymax=upr), fill="green",alpha=.1) + geom_ribbon(data=sconf_interval, aes(ymin=lwr,ymax=upr), fill="green",alpha=.2)

Changing the upper and lower value displayed on the x-axis:
 + scale_x_continuous(name="ACT", limits=c(17, 36)) 

To change the color of the regression line, prediciton interval and confidence interval:
+ geom_smooth(method = "lm", se=FALSE, colour="green") 
+ geom_ribbon(data=spred_interval, aes(ymin=lwr,ymax=upr), fill="green",alpha=.1) 
+ geom_ribbon(data=sconf_interval, aes(ymin=lwr,ymax=upr), fill="green",alpha=.2)



#Code for Part Five:
Bbar <- 3.272
Cbar <- 3.25706491
Fbar <- 3.32337306
Hbar <- 3.37247111
Ibar <- 3.34700917
Nbar <- 3.3056096
Rbar <- 3.40136
Sbar <- 3.25121555

nB = 679
nC = 909
nF = 193
nH = 225
nI = 219
nN = 607
nR = 100
nS = 733

sB = 0.395
sC = 0.49744747
sF = 0.50665347
sH = 0.62857914
sI = 0.56655791
sN = 0.50740917
sR = 0.45735464
sS = 0.58458498
  
seB = sB/sqrt(nB)
seC = sC/sqrt(nC)
seF = sF/sqrt(nF)
seH = sH/sqrt(nH)
seI = sI/sqrt(nI)
seN = sN/sqrt(nN)
seR = sR/sqrt(nR)
seS = sS/sqrt(nS)

Division = c("Business","Communication", "Fine Arts","Humanities", "Int. Studies", "Natural Science", "Religion & Phil.", "Social Science")
GPA = c(Bbar,Cbar, Fbar, Hbar, Ibar, Nbar, Rbar, Sbar)
serrors = c(seB,seC, seF, seH, seI, seN, seR, seS)
dframe = data.frame(Division, GPA, serrors)

Legend = Division
ggplot(dframe, aes(x=Division,y=GPA, fill=Legend)) + ggtitle("Division vs Major") +scale_y_continuous(breaks=seq(0,4,.5))+ theme_bw() +theme(plot.title = element_text(hjust = 0.5)) + geom_bar(stat="identity") + geom_errorbar(aes(ymin=avg-serrors, ymax=avg+serrors), width=.1)
