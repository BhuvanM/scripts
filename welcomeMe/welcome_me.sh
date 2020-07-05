# /bin/bash
# Author: BhuvaneshwarM
# A utility on login that lets me create project with ease


echo "Master Wayne
Starting the day are we"

#Variables to be changed for owner
PROJECTDIR=/home/pi/myProjects

createProject (){
    echo "Project Name:"
    read PROJECT
    CREATE=0
 while [ $CREATE -eq 0 ]	
 do	 
    if [ ! -d $PROJECTDIR/$PROJECT ]
      then	
        mkdir -p $PROJECTDIR/$PROJECT
       	echo "Project ${PROJECT} has commenced"
	select typ in gitSetup normalSetup;
         do
         case $typ in
             gitSetup)
             setupGit $PROJECT
	     CREATE=1;
             break
	     return
	     ;;
             normalSetup)
             setupNormal $PROJECT
	     CREATE=1
	     break
	     return
	     ;;
             *) echo "...Pardon?"
             ;;
         esac
         done

      else
    
        echo "The project already exists"
	break
	fi
done 
}

setupGit(){	
  echo "What name do you want to give your remote repo?"
  read REPO_NAME

  echo "repo description: "
 read DESCRIPTION

 PROJECT_PATH=$PROJECTDIR/$1
 
 echo "git username?"
 read USERNAME
 echo "Enter email id for git config"
 read EMAIL
 cd "$PROJECT_PATH"
 git init
 sudo touch README.MD
 git add README.MD
 git config user.email "$EMAIL"
 git config user.name "$USERNAME"
 git commit -m 'initial commit -setup [automated with script]'
 curl -u ${USERNAME} https://api.github.com/user/repos -d "{\"name\": \"${REPO_NAME}\", \"description\": \"${DESCRIPTION}\"}"
 git remote add origin https://github.com/${USERNAME}/${REPO_NAME}.git
 git push --set-upstream origin master
 cd "$PROJECT_PATH"
 echo " *** You're now in your project root. ***"
 echo "All set"
}

setupNormal(){
   cd $PROJECTDIR/$1
   vim -n "$1" <<EndOfCommands
  i
  Project Index: $1
  created at: `date`
  Author: BhuvaneshwarM
  
  Description:
  
  
  :x
EndOfCommands

echo "***You are now in project root ***"
}

goToProject(){
  
  select opnPrj in $PROJECTDIR/*
  do
   case $opnPrj in
	   $PROJETDIR/*)
     cd $opnPrj
     break
     return
     ;;
     *) echo "No such project exist"
     break     
   esac
  done
}



moo(){
    
     if [ $(dpkg-query -W -f='${Status}' cowsay 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
  		echo "OOOOh its worth the wait, hang on. And ofcourse trust me with your password"
		sleep 1
		sudo apt-get install cowsay;
    fi
    cowsay you suck
}


select opt in newProject openProject feelingLucky quit;

do
case $opt in
	newProject)
		createProject
                break
	        return
	;;

	openProject)
#Trivial functionality
 	  	goToProject
	  	break
	  	return
	;;
	feelingLucky)
		moo
		break
		return
	;;
	quit)
		echo "Alrighty"
		break
        	return
	;;
	*) 	echo ".....what? ${opt}"
	;;
esac
done
