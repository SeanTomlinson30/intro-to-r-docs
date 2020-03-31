#
# Introduction to the R statistics environment
# Examples and Exercises.
#

# clear R global environment
rm(list=ls())

# Clear plots in R studio plot window
if(!is.null(dev.list())) dev.off()

#store original graphical parameter set
opar <- par(no.readonly=TRUE)


#
# Exercise 01a
#

#find out where you are - file are read and written to the location
getwd()

# list file in the current working directory
list.files()

# set path to working directory
setwd("/home/tmed12345/Desktop/R_Teaching/")

#confirm where you are
getwd()

# list file in the current working directory
list.files()

# c() is a really useful function
num_vec <- c(1,2,3,4,5) # stores integers 1 to 5
num_vec
num_vec2 <- c(1:5) # same as above, stores 1 to 5
num_vec2

# Used for specifying multiple argument for functions/subsetting data

#legend(x = 25,y = 110,legend = c("drug X","drug Y"))
# plot a legend on a graph with two names (not executed)

num_vec[c(1,5)] # first and fifth element of num_vec


# You can perform numerical operations on objects
# set up objects
a <- 3; b <- 5 # scalars
i <- c(1,2,3) # vector

# add together scalar objects
sum_ab <- a +b
sum_ab

# multiply i by 3
triple_i <- i*3
triple_i

#
#Make 3 vector (called "object_x", y and z) in the R environment
#
object_x = c(1, 2, 3, 4, 5)
object_y = c(10, 9, 8, 7, 6)
object_z = c("a", "list", "of ", "words")

#list of available objects
ls()

#structure of objects
str(object_x)
str(object_y)
str(object_z)

# summary of each object
summary(object_x)
summary(object_y)
summary(object_z)

# positions in a vector
object_z2 <- object_z[2]
object_z2

#range of elements in an object
object_z[2:3]

#Make a simple x-y scatterplot using the two vectors of numbers
plot(x=object_x, y=object_y,main = "Y against X",xlab = "x value",ylab = "y value",type = "b")

#
# Exercise 01b - read in data created in MS Excel 
#

#check current working directory
getwd()

#read in CSV file
drug_data_df <- read.table(file = "drug_data.csv",header = T,sep = ",")

# write a CSV file copy of drug_data_df
write.table(x = drug_data_df,file = "drug_data_copy.csv",sep = ",",row.names = F,col.names = T)

# write a tab delimited file copy of drug_data_df
write.table(x = drug_data_df,file = "drug_data_copy.txt",sep = "\t",row.names = F,col.names = T)

# structure and summary stats
str(drug_data_df)
summary(drug_data_df)
dim(drug_data_df)

#plot activity vs. conc.
plot(x = drug_data_df$Dosage,y = drug_data_df$drugX,main="Drug activity vs. Dosage",xlab="Dosage (mg/Kg)",ylab = "Activity",type="b",pch=15)
lines(x = drug_data_df$Dosage,y = drug_data_df$drugY,type = "b",col="red",pch=17)
legend(x = 25,y = 110,legend = c("drug X","drug Y"),col = c("black","red"),pch=c(15,17))

#
# Exercise 02
#

# read in file full of proteomic data into dataframe object
df <- read.csv(file = "Anopheles_gambiae_peptide_dataset.txt",sep = "\t",header = T,na.strings = NA)

#show first few lines of df
head(df)
# first 20 rows
head(df,n=20)

# summarise each column within df
summary(df)

# number of rows in df
nrow(df)

# number of columns in df
ncol(df)

# column names
names(df)

#subset data by column or row assign subset to new object.
# column name
df$AminoAcids # pick column named AminoAcids.
df20r = df[1:20,]# rows 1 to 20 to dataframe df20r
df[1:100,] # means "row 1 to 100 and all columns of df"
df[2, 1:3] # means "row 2 and columns 1 to 3 of df"
df[c(1,10,12),] # means "row1, 10 and 12 and all columns of df"

# subsetting rows based on column value
df_gt1000_aminoAcids <- df[df$AminoAcids > 1000,]
dim(df_gt1000_aminoAcids)

# add new column populated with 0
df$new = 0
df$new

# new column with derived value from other columns
# dealt with row-wise 
df$Ala_proportion = df$Ala / df$AminoAcids
df$Ala_proportion

# work out how drugable experessed proteins are
df$aromatic_res = df$Phe + df$Tyr + df$Trp
df$aromatic_proportion = df$aromatic_res/df$AminoAcids
df$aromatic_proportion
summary(df$aromatic_proportion)

#
# Exercise 3
#

#if operating in a native R environment
#dev.new()

#graphical parameters stored in par object
par()

#store original graphical parameter set
opar <- par(no.readonly=TRUE)

# set graphical parameter mfrow (number of graphs in a row, in a matrix of graphs)
par(mfrow=c(1,1))

# plot scatter plot
plot(x=df$AminoAcids, y=df$Leu,main="Leucine Vs. Amino acid Counts",xlab="Amino Acid Count",ylab="Leucine Count")

#You can choose to plot data on a log scale in plot with the "log=" argument
# careful of 0 values as log(0) = ???.

#Create new column which adds 1 to all column values 
df$log_AminoAcids_plusOne <- log10(df$AminoAcids+1)

#Plot the log of the new +1 variable:
plot(x=df$log_AminoAcids_plusOne,y=df$Leu,log="x")

# plot scatter plot
plot(x=df$AminoAcids, y=df$Leu,main="Leucine Vs. Amino acid Counts",xlab="Amino Acid Count",ylab="Leucine Count")

# place horizontal line at 250 on the vertical axis
abline(h=250,col="red")

# if operating in native R environment
#dev.copy(jpeg,'myplot_1.jpg')
#dev.off()

# controlling the width and height of the plot area
#dev.new(width=7, height=3.5)
#par(mfrow=c(1,1))
#plot(x=df$AminoAcids, y=df$Leu)

#Arranging multiple plots side-by-side, or one-above-another
par(mfrow=c(1,2))
plot(x=df$AminoAcids, y=df$Leu)
plot(x=df$AminoAcids, y=df$Ala)

# explore available colours
colours()

# plot 1x1 scatterplot with point colours, shape and size changed
par(mfrow=c(1,1))
plot(x=df$AminoAcids, y=df$Leu, pch=19, cex=0.4, col="red")

# controlling text in a plot
# scatterplot with red main title with font x2 default size
plot(x=df$AminoAcids,y = df$Leu,main="Title Text",cex.main=2,col.main="red")

# scatterplot with blue non-standard axis labels at half default size
plot(x = df$AminoAcids,y = df$Leu,xlab="Length",ylab = "Leucines",cex.lab=0.5,col.lab="blue")

# scatterplot with blue axis numbers at half the default size
plot(x=df$AminoAcids, y=df$Leu, cex.axis=0.5, col.axis="blue")

# Re-scaling a plot to show data within a certain range
plot(x=df$AminoAcids, y=df$Leu, xlim=c(0,5000), ylim=c(0,500))

#Controlling how axes are displayed:
plot(x=df$AminoAcids, y=df$Leu, xlim=c(0,5000), ylim=c(0,500), axes=F)
axis(side=1)
axis(side=2, at=c(0,250,500), labels=c(0,250,500), las=1)

# add new datapoints to existing graph
plot(x=df$AminoAcids, y=df$Leu, col="black")
points(x=df$AminoAcids, y=df$Val, col="red")

# Add legend
legend(x=0, y=1000, legend=c("Leu","Val"), pch=1, col=c("black","red"))

# try different positions of legend
legend(x=12000, y=1000, legend=c("Leu","Val"), pch=1, col=c("black","red"))
legend(x=12000, y=1500, legend=c("Leu","Val"), pch=1, col=c("black","red"))

legend("top", legend=c("Leu","Val"), pch=1, col=c("black","red"))

# add additional line to plot
abline(h=100, lty=2, lwd=4, col="red")
abline(v=200, lty=3, lwd=0.5, col="blue")


#Other plots

#
#histogram of amino acid counts amongst genes
#

# now in presentation
hist(df$AminoAcids,col = "red",main = "Histogram of Amino Acids in Protein",freq = T)
# display vertical line at maximum amino acid count value
AminoAcids_Max = max(df$AminoAcids)
abline(v = AminoAcids_Max)


# graphical demos of the capabilities of R
demo(topic = "graphics")
demo(topic = "persp")

# restore original graphical parameter set
par(opar)

#
# end of R script
#