# OPLS example
source("http://pastebin.com/raw.php?i=JVyTrYRD") # source Devium

#generate some random data and Y's
set.seed(1234)
data<-matrix(rnorm(10000,0,1),nrow=100, ncol=100)
simple.y<-matrix(rep(1:2,50),,1)
complex.y<-matrix(sample(1:2,400,replace=T),,4)

#scale data 
scaled.data<-data.frame(scale(data,scale=T,center=T)) 


# make exploratory model to determine orthogonal LV (OLV) number 
comp<-3 # maximum number of latent variables (LVs)
pls.y<-simple.y
#fit 1:limit LV/OLV models to overview optimal LV and OLV
optimal.model<-optimize.OPLS(max.LV=comp, # max LV
							tolerance =0.01, #tolerance for accepting higher error models but which are simpler
							pls.y=pls.y,pls.data=scaled.data, # y and data
							validation = "LOO",method="oscorespls",cv.scale=F) # see pls for theses options

#view suggestions
optimal.model
# suggests 3 components all OLV...

#build optimized model based on optimal.model suggestions
mods1<-OSC.correction(pls.y=pls.y,pls.data=scaled.data,comp=optimal.model$LV,OSC.comp=optimal.model$OLV,validation = "LOO",method="oscorespls",cv.scale=T)
final<-get.OSC.model(obj=mods1,OSC.comp=optimal.model$OLV) # get all model information

#view model scores
group<-factor(join.columns(pls.y))#visualize levels of y 
plot.PLS.results(obj=final,plot="scores",groups=group)

#the next step for modeling would be to validate, but I will instead show complex. y modeling
# make exploratory model to determine orthogonal LV (OLV) number 
comp<-6 # maximum number of latent variables (LVs)
pls.y<-complex.y
#fit 1:limit LV/OLV models to overview optimal LV and OLV
optimal.model<-optimize.OPLS(max.LV=comp, # max LV
							tolerance =0.01, #tolerance for accepting higher error models but which are simpler
							pls.y=pls.y,pls.data=scaled.data, # y and data
							validation = "LOO",method="oscorespls",cv.scale=F) # see pls for theses options

#view suggestions
optimal.model
# suggests 3 components all OLV...

#build optimized model based on optimal.model suggestions
mods1<-OSC.correction(pls.y=pls.y,pls.data=scaled.data,comp=optimal.model$LV,OSC.comp=optimal.model$OLV,validation = "LOO",method="oscorespls",cv.scale=T)
final<-get.OSC.model(obj=mods1,OSC.comp=optimal.model$OLV) # get all model information

#view model scores
group<-factor(join.columns(pls.y))#visualize levels of y 
plot.PLS.results(obj=final,plot="scores",groups=group)

#an alternative to modeling a multiple Ys is to define a single Y based on the multiple columns
# this will try to organize all group scores in one dimension (LV1)
pls.y<-as.numeric(as.factor(join.columns(complex.y))) # create numeric representation
#fit 1:limit LV/OLV models to overview optimal LV and OLV
optimal.model<-optimize.OPLS(max.LV=comp, # max LV
							tolerance =0.01, #tolerance for accepting higher error models but which are simpler
							pls.y=pls.y,pls.data=scaled.data, # y and data
							validation = "LOO",method="oscorespls",cv.scale=F) # see pls for theses options

#view suggestions
optimal.model
# suggests 3 components all OLV...

#build optimized model based on optimal.model suggestions
mods1<-OSC.correction(pls.y=pls.y,pls.data=scaled.data,comp=optimal.model$LV,OSC.comp=optimal.model$OLV,validation = "LOO",method="oscorespls",cv.scale=T)
final<-get.OSC.model(obj=mods1,OSC.comp=optimal.model$OLV) # get all model information

#view model scores
group<-factor(join.columns(pls.y))#visualize levels of y 
plot.PLS.results(obj=final,plot="scores",groups=group) 


