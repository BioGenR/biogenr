dat<- data.frame(t=seq(0, 2*pi, by=0.1) )
xhrt <- function(t) 16*sin(t)^3
yhrt <- function(t) 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t)
dat$y=yhrt(dat$t)
dat$x=xhrt(dat$t)
with(dat, plot(x,y, type="l"))

with(dat, polygon(x,y, col="hotpink"))   
points(c(10,-10, -15, 15), c(-10, -10, 10, 10), pch=169, font=5)


text(1,"Anneler Günü Kutlu Olsun!",col='white',cex=1)
}

