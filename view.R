#!/usr/bin/env Rscript
#egrep ' -i all.tsv
library(dplyr)
library(ggplot2)

d <- 
 read.table('txt/onthesnowinfo.tsv',header=F,sep="\t",quote="") %>% 
 `colnames<-`(c('place','metric','value'))  %>% 
 mutate(value=as.numeric(gsub('ac|%|\\$|ft|in|"|mi','',value)))

# wide for plotting
d.wide <- 
 d %>% 
 filter(grepl('snowbase|^runs$|longest|skiable|expert|advanced|viertical|cost|total number of lifts',metric,perl=T,ignore.case=T)) %>%
 spread(metric,value) %>% 
 # convert percent runs to number runs
 mutate(advanced=floor(advanced*runs/100),expert=floor(expert*runs/100))
# easier names
colnames(d.wide) <- (c(tolower(gsub(' .*','',colnames(d.wide)))))

d.all <-
 read.table('txt/cost.tsv',header=T,sep="\t") %>% 
 merge(d.wide) %>%
 merge( read.table('txt/distances.tsv',header=T,sep="\t") )

p<-
 ggplot(d.all) +
 aes(y=price,x=dist.min,size=skiable,color=runs,label=place) +
 geom_text(aes(size=NULL),vjust=-1) + geom_point() +
 theme_bw()

ggsave(p,file='plot.png')



