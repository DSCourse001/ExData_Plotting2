## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.
require(data.table)
require(graphics)
require(grDevices)
dt<-data.table(NEI)[,sum(Emissions),by=year]
setnames(dt,c("Year","Emissions"))

png("plot1.png",width=5.25,height=5.25,units="in",res=120)

with(dt,{
    bp<-barplot(Emissions,axes=F,names.arg=Year,col=rainbow(10)
                ,main="US PM2.5 Emissions in Tons")
    text(bp,0, formatC(round(Emissions,0),big.mark=",",format = "fg")
         ,pos=3,cex=1,font=2)
    })

dev.off()