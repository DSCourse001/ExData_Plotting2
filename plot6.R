## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
require(data.table)
require(grDevices)
require(ggplot2)
dt<-data.table(NEI)[fips %chin% c("06037","24510") & type=="ON-ROAD",sum(Emissions),by=c("year","fips")]
dt<-dt[fips=="06037",City:="Los Angeles County,\nCalifornia"]
dt<-dt[fips=="24510",City:="Baltimore City,\nMaryland"]
dt$fips<-NULL
setnames(dt,c("Year","Emissions","City"))
setcolorder(dt,c("Year","City","Emissions"))
setorder(dt,Year,City)
dt$Year<-factor(dt$Year)

plot<-ggplot(data=dt,aes(x=Year,y=Emissions,fill=City,group=City,colour=City)) +
  geom_bar(stat="identity",alpha = 0.4) +
  geom_smooth(method="lm",se=F,size=1.2,alpha = 1) +
  labs(list(
    title="PM2.5 Motor Vehicle Sources Emissions",
    x="Year",
    y="Emissions, Tons"
  ))
ggsave("plot6.png",plot=plot,width=5.25,height=5.25,units="in",dpi=120)