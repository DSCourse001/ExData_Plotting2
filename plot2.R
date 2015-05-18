## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in 
# the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
require(data.table)
require(graphics)
require(grDevices)
dt<-data.table(NEI)[fips == "24510",sum(Emissions),by=year]
setnames(dt,c("Year","Emissions"))

png("plot2.png",width=5.25,height=5.25,units="in",res=120)

with(dt,{
  bp<-barplot(Emissions,axes=F,names.arg=Year,col=rainbow(10))
  title("PM2.5 Emissions in Tons",line=2)
  title("Baltimore City, Maryland",line=1)
  text(bp,0, formatC(round(Emissions,0),big.mark=",",format = "fg")
       ,pos=3,cex=1,font=2)
})

dev.off()