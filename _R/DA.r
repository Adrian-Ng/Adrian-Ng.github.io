#A generalized function for LDA and QDA 
DA <- function
	(	trainObject
	,	testObject
	,	trainLabel
	,	lqflag		# 0 == LDA; 1 == QDA;
	) {
	#INITIALISE DATA FRAMES
		df.trainObject 												<- data.frame(trainObject);
		df.testObject 												<- data.frame(testObject);
		df.trainLabel												<- data.frame(trainLabel);	
	#PARAMETERS
		#number of attributes
		p = ncol(df.trainObject);
		#number of observations
		n = nrow(df.trainObject);
		#number of classes
		k = length(unique(trainLabel));
		#class names
		K = unique(trainLabel);
		df.K <- data.frame(K);
	#CALCULATE PRIOR PROBABILITIES OF LABEL
		aggLabel													<- data.frame(table(df.trainLabel));
		pihat 														<- data.frame(aggLabel,aggLabel$Freq/n);
		names(pihat)[3]												<- paste("pihat");
	#ATTRIBUTE AVERAGE
		mu															<- apply(df.trainObject,2,mean);
	#CLASS AVERAGES	PER ATTRIBUTE								
		kmu															<- aggregate(	x 	 = trainObject
																				,	by	 = list(trainLabel)
																				,	data = trainObject
																				,	FUN  = mean);	
	#COMMON COVALENCE MATRIX (ccm) FOR LDA	
		#convert mu vector into mu matrix of n rows
		ccm.mu														<-   matrix(data = 1, n) %*% mu;
		#find the residuals of the mean
		ccm.diff													<- as.matrix(trainObject - ccm.mu);
		#square and divide by (n-1)
		ccm.cov														<- (n-k)^-1 * t(ccm.diff) %*% ccm.diff;
		#cleanup
		rm(ccm.mu);
		rm(ccm.diff);
		rm(mu);
	#k-COVARIANCE ARRAY (3d matrix in r is an array) FOR QDA
		#add index to trainObject to preserve order
		df.trainObject.join											<- data.frame(rownames(df.trainObject),df.trainObject,df.trainLabel);
		names(df.trainObject.join)[1]								<- c("TrainID");
		df.trainObject.join$TrainID									<- as.numeric(levels(df.trainObject.join$TrainID))[df.trainObject.join$TrainID]
		#"inner join" the training set with the kmu so that the classes match for subtraction
		inner.join													<- merge	(	df.trainObject.join
																				,	kmu
																				,	by.x = p + 2
																				,	by.y = 1);
		#for preserving order
		#when you use merge in R, it doesn't keep order, which is problematic but manageable.
		#the alternative is using loops which would be slow
		rownames(inner.join) <-inner.join$TrainID;
		inner.join <- inner.join[order(inner.join$TrainID),];
		#subtraction
		subt														<- data.frame(inner.join[,2],(inner.join[(1:p)+2] - inner.join[(1:p)+p+2]));
		subt 														<- as.matrix(subt[,-1]);	
		#create k-Covariance array			
		kcov 														<- array(NA, dim=c(p,p,k));		
		#populate k-Covariance array			
		kcov[1:p,1:p,as.numeric(rownames(df.K))]					<- apply(	df.K
																			,	1
																			,	function(x) (1/(aggLabel[(aggLabel[,1]==x),2]-1)) * t(subt[trainLabel==x,]) %*% subt[trainLabel==x,]
																				)
	#CALCULATE DELTAS			
		#for lda			
		if (lqflag == 0) {			
		delta														<- apply(	df.K
																			,	1																			
																			,	function(x) 
																				as.matrix(testObject) %*% solve(ccm.cov) %*% t(as.matrix(kmu[kmu[,1]==x,2:(p+1)]))
																			-	matrix(data=0.5, nrow(df.testObject)) %*% as.matrix(kmu[kmu[,1]==x,2:(p+1)]) %*% solve(ccm.cov) %*% t(as.matrix(kmu[kmu[,1]==x,2:(p+1)]))
																			+ 	log(pihat[pihat[,1]==x,3])
																			)	
			}				
		#for qda			
		if(lqflag == 1) {							
		delta														<- apply(	df.K
																			,	1
																			,	function(x) 
																			-	matrix(data=0.5, nrow(df.testObject)) %*% (if (p > 1) {log(det(kcov[,,which(df.K[1] == x)]))} else if (p == 1) {log(kcov[,,which(df.K[1] == x)])})																
																			-	0.5 * diag(as.matrix(testObject) %*% solve(kcov[,,which(df.K[1] == x)]) %*% t(as.matrix(testObject)))
																			+	as.matrix(testObject) %*% solve(kcov[,,which(df.K[1] == x)]) %*% t(as.matrix(kmu[kmu[,1]==x,2:(p+1)]))
																			-	matrix(data=0.5, nrow(df.testObject)) %*% as.matrix(kmu[kmu[,1]==x,2:(p+1)]) %*% solve(kcov[,,which(df.K[1] == x)]) %*% t(as.matrix(kmu[kmu[,1]==x,2:(p+1)]))
																			+ 	log(pihat[pihat[,1]==x,3])
																			)
			}																								
	#CALCULATE DIFFERENCE BETWEEN DELTAS
		delta.diff 													<- delta[,1] - delta[,2]
		result 														<- ifelse(delta.diff > 0,df.K[1,1],df.K[2,1]);	
		return(result);
	}
