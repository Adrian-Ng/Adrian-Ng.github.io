# A generalized function for calculating nearest neighbours for any value of k
# This is a set based solution that aims to optimise for speed by avoiding as many loops as possible.
# The only loop is for values of k
# Assignment constraints: cannot use sort or order.
knn_general <- function
	(	trainObject
	, 	testObject
	, 	trainLabel
	,	kValue
	){
#	R does not appear to have a function for finding modal values
#	I have encapsulated my method into a function, because I am using an "apply" in the main function.
#	For a single testObject, I aggregate to return the count of each label.
#	Then I return the max count of that aggregate - i.e. the most popular label.	
	modlab 	<- function  
		(xx){	
		modlab <- aggregate(	as.numeric(xx)
							,	by=list(as.numeric(xx))
							,	FUN = length
							)	[which.max(aggregate(	as.numeric(xx)
													,	by=list(as.numeric(xx))
													,	FUN = length
													)	$x
											),1
								]
		return(modlab)
	}
	#INITIALISE DATA FRAMES AND CREATE IDENTITIES
		trainObject 			<- data.frame(rownames(trainObject),trainObject);
		names(trainObject)[1]	<- paste("trainID");
		testObject 				<- data.frame(rownames(testObject),testObject);
		names(testObject)[1]	<- paste("testID");
		trainLabel				<- data.frame(trainLabel);
		trainLabel				<- data.frame(rownames(trainLabel),trainLabel);
		names(trainLabel)[1]	<- paste("labelID");
	#CREATE DATA FRAME FOR STORING PREDICTED LABELS 
		#this stores the predicted labels for our testObject of every nearest neighbour at any level of k 
		predicted				<- data.frame(testObject[,1]);
		names(predicted)[1]		<- paste("testID");	
		#convert testID from factor to numeric so as to maintain ordering
		predicted$testID 		<- as.numeric(levels(predicted$testID))[predicted$testID]		
	#	"CROSS JOIN" FOR EVERY POSSIBLE COMBINATION FOR TEST AND TRAIN OBJECT
		#this means Euclidean distance need only be computed once
		cross.join 				<- data.frame(merge(	trainObject
													,	testObject
													,	by=NULL
													));
	# GET LENGTH OF cross.join MINUS THE IDENTITIES AND HALF IT
		# so that when it comes to subtracting, our test and train columns are correctly aligned
		n 						<- (length(cross.join)-2)/2;
		o						<- length(cross.join);
		p						<- o-n;
	#	EUCLIDEAN DISTANCE		
		subt 					<- cross.join[,c(2:(n+1))] - cross.join[,c((p+1):o)];
		square					<- subt^2;
		sums					<- rowSums(square);
		eDistance 				<- data.frame(	cross.join[,c("trainID")]
											 ,	cross.join[,c("testID")]
											 ,	sums);
	#	CLEANUP
		rm(subt);
		rm(square);
		rm(sums);
		rm(n);
		rm(o);
		rm(p);		
	#	CHANGE ATTRIBUTE NAMES IN eDistance FOR CLARITY
		names(eDistance)[1]		<- paste("trainID");
		names(eDistance)[2]		<- paste("testID");
		names(eDistance)[3]		<- paste("Distance");
	#	LOOP THROUGH kValue
	for (k in 1:kValue) {			
		#	AGGREGATE MIN Distance IN GROUPS OF testID TO FIND THE NEAREST NEIGHBOUR		
			aggdata						<- aggregate(Distance~testID, eDistance, FUN = min);
		#	"INNER JOIN" TO RETRIEVE trainID
			aggdata						<- merge(	eDistance
												,	aggdata
												,	by.x=c("testID","Distance")
												,	by.y=c("testID","Distance")
												);	
		#	REMOVE DUPLICATES INTRODUCED BY INNER JOIN		
			dupe 						<- duplicated(aggdata[,c("testID")]);				
			aggdata 					<- data.frame(aggdata,dupe);			
			aggdata 					<- aggdata[!dupe,];
			aggdata						<- aggdata[,c(1:3)];
		#	"INNER JOIN" aggdata AND trainLabel to FETCH LABEL FROM trainLabel
			labl						<- merge(	aggdata
												,	trainLabel
												, 	by.x=c("trainID")
												,	by.y=c("labelID")
												);
			names(labl)[4]				<- paste("label_",k);
		#	"INNER JOIN" predicted AND labl to STORE LABEL in predicted
			predicted 					<- merge(	predicted
												, 	labl[,c("testID", paste("label_",k))]
												,  	by.x=c("testID")
												, 	by.y=c("testID")
												);
			n							<- length(predicted);
		#	REMOVE AGGDATA ROWS FROM eDistance
			#	concatenate trainID and testID to generate "super indices"
			aggdata 					<- within(	aggdata, superID 	<- paste(trainID, testID, sep='_'));
			eDistance					<- within(	eDistance, superID 	<- paste(trainID, testID, sep='_'));
			#	flag rows for deletion on eDistance where superID exists in both eDistance and aggdata
			bin 						<- eDistance$superID %in% aggdata$superID;
			eDistance					<- data.frame(eDistance, bin);
			#	drop rows
			eDistance					<- eDistance[!bin,];
			#	prepare eDistance for next iteration
			eDistance					<- eDistance[,(1:3)];
	}
	#	DECIDE WINNING LABEL	
	#remove testID
	predicted <- predicted[,c(2:length(predicted))]
	#for each row, apply the modlab function to return the modal label
	if (kValue > 1) {
					final <- apply(predicted,1, FUN = modlab)
					return(final)
					}
	if (kValue ==1 ) {
					return (predicted)
					}
	}