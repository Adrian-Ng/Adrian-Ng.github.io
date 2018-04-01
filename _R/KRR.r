KRR <- function
	(	trainObject
	,	testObject
	,	trainLabel
	,	lambda 		
	,	km 				#kernel method; km = 0 polynomial; km = 1 radial; km = 2 for linear
	,	parameter		#treat as d for polynomial or treat as g for radial
		) {
	#POLYNOMIAL KERNEL	
	polynomial_k <- function (x, x.prime, d) {
		return(I((1 +	x %*% x.prime)^d));		
		};
	#RADIAL KERNEL
	radial_k <- function (x, x.prime, g) {	
			r <- apply(		x.prime
						,	1
						,	function(a)	
							colSums(apply	( 	x
											,	1
											,	function(b)
												(b - a)^2)
												)
						);		
		return(exp(-g*r));
		};
	#LINEAR KERNEL
	linear_k <-function (x,x.prime) {
		return(x %*% x.prime);
		};		
	#INITIALISE DATA FRAMES
		df.trainObject 												<- data.frame(trainObject);
		df.testObject 												<- data.frame(testObject);
		df.trainLabel												<- data.frame(trainLabel);			
	#INITIALIZE MATRICES
		m.trainObject 												<- as.matrix(trainObject);
		m.testObject 												<- as.matrix(testObject);
		m.trainLabel												<- as.matrix(trainLabel);			
	#PARAMETERS
		#number of attributes
		p = ncol(df.trainObject);
		#number of observations
		n = nrow(df.trainObject);		
	#RETURN K and k
		#for polynomial
	if (km == 0) {
		K															<- polynomial_k(m.trainObject,t(m.trainObject),parameter);
		k															<- polynomial_k(m.trainObject,t(m.testObject),parameter);
		}
		#for radial
	else if (km == 1) {
		K															<- radial_k(df.trainObject,df.trainObject,parameter);
		k															<- radial_k(df.trainObject,df.testObject,parameter);
		}
		#for linear
	else if (km == 2) {
		K															<- linear_k(m.trainObject,t(m.trainObject));
		k															<- linear_k(m.trainObject,t(m.testObject));
		};	
	#CALCULATE Y HAT
		y.hat 														<- trainLabel %*% solve(lambda*diag(n) + K) %*% k;
		return (y.hat);
	};